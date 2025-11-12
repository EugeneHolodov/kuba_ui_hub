# Deployment Guide for Kuba UI Hub

This guide will help you deploy both the Flutter web app and the Node.js backend.

## Prerequisites

- GitHub account with a repository
- Account on a free hosting service for the backend (Render, Railway, or similar)

## Part 1: Deploy Flutter Web App to GitHub Pages

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions** (not "Deploy from a branch")
4. Save the settings

### Step 2: Update Repository Name in Workflow

The workflow is configured to deploy to `/kuba_ui_hub/`. If your repository has a different name:

1. Open `.github/workflows/deploy-web.yml`
2. Update the `--base-href` parameter in the build step:
   ```yaml
   run: flutter build web --release --base-href "/YOUR_REPO_NAME/"
   ```

### Step 3: Push to Main Branch

The workflow will automatically trigger when you push to the `main` or `master` branch:

```bash
git add .
git commit -m "Setup CI/CD for web deployment"
git push origin main
```

### Step 4: Access Your App

After the workflow completes (check the **Actions** tab), your app will be available at:
- `https://YOUR_USERNAME.github.io/kuba_ui_hub/`

## Part 2: Deploy Backend API

You have several free options for hosting the backend:

### Option A: Render.com (Recommended - Free Tier Available)

1. **Sign up** at [render.com](https://render.com) (free tier available)

2. **Create a new Web Service**:
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select the `backend` folder as the root directory

3. **Configure the service**:
   - **Name**: `kuba-ui-hub-backend`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Plan**: Free

4. **Environment Variables** (if needed):
   - `NODE_ENV`: `production`
   - `PORT`: (auto-set by Render)

5. **Deploy**: Click "Create Web Service"

6. **Get your backend URL**: After deployment, you'll get a URL like:
   - `https://kuba-ui-hub-backend.onrender.com`

### Option B: Railway.app (Free Tier Available)

1. **Sign up** at [railway.app](https://railway.app)

2. **Create a new project**:
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository

3. **Configure the service**:
   - Select the `backend` folder
   - Railway will auto-detect Node.js
   - The `railway.json` file will configure the deployment

4. **Get your backend URL**: After deployment, you'll get a URL like:
   - `https://kuba-ui-hub-backend.up.railway.app`

### Option C: Other Free Hosting Options

- **Fly.io**: Free tier with 3 shared VMs
- **Heroku**: Limited free tier (may require credit card)
- **Vercel**: Free tier for serverless functions

## Part 3: Update Flutter App with Backend URL

Once your backend is deployed, you need to update the Flutter app to use the production backend URL.

### Method 1: Build-time Environment Variable (Recommended)

1. Update the GitHub Actions workflow to include the backend URL:

   Edit `.github/workflows/deploy-web.yml` and add an environment variable:

   ```yaml
   - name: Build Flutter web app
     working-directory: ./flutter
     env:
       API_BASE_URL: https://your-backend-url.onrender.com
     run: flutter build web --release --base-href "/kuba_ui_hub/" --dart-define=API_BASE_URL=${{ env.API_BASE_URL }}
   ```

2. Update `flutter/lib/services/api_service.dart` to use the build-time variable:

   The code already supports this via `String.fromEnvironment`. Make sure your build command includes `--dart-define=API_BASE_URL=YOUR_URL`.

### Method 2: Runtime Configuration (Alternative)

For a more flexible approach, you can create a configuration file that gets loaded at runtime:

1. Create `flutter/web/config.js`:
   ```javascript
   window.APP_CONFIG = {
     API_BASE_URL: 'https://your-backend-url.onrender.com'
   };
   ```

2. Update `flutter/web/index.html` to load this config before Flutter:
   ```html
   <script src="config.js"></script>
   ```

3. Update `api_service.dart` to read from JavaScript (requires `dart:js_interop` or `package:js`).

## Part 4: Update CORS Settings

Make sure your backend allows requests from your GitHub Pages domain:

1. In `backend/server.js`, update the CORS configuration:

   ```javascript
   const corsOptions = {
     origin: [
       'https://YOUR_USERNAME.github.io',
       'http://localhost:3000', // For local development
     ],
     credentials: true,
   };
   
   app.use(cors(corsOptions));
   ```

2. Redeploy your backend after making this change.

## Testing

1. **Test locally first**:
   ```bash
   # Terminal 1: Start backend
   cd backend
   npm install
   npm start
   
   # Terminal 2: Run Flutter web
   cd flutter
   flutter run -d chrome --web-port=8080
   ```

2. **Test production**:
   - Visit your GitHub Pages URL
   - Check browser console for any CORS or API errors
   - Test the app functionality

## Troubleshooting

### CORS Errors
- Ensure your backend CORS settings include your GitHub Pages domain
- Check that the backend URL in the Flutter app is correct

### 404 Errors on GitHub Pages
- Make sure the `--base-href` matches your repository name
- Check that GitHub Pages is set to use "GitHub Actions" as the source

### Backend Not Responding
- Check the backend logs on your hosting platform
- Verify environment variables are set correctly
- Ensure the database is initialized (run `npm run init-db` if needed)

### App Not Loading
- Check browser console for errors
- Verify all assets are being loaded correctly
- Clear browser cache and try again

## Notes

- GitHub Pages is free and provides HTTPS automatically
- Free hosting tiers may have cold start delays (first request after inactivity)
- Consider upgrading to paid tiers for production use
- The app is configured to display in an iPhone 16 Pro Max frame (430x932px) on desktop, and full-screen on mobile devices

## Support

If you encounter issues:
1. Check the GitHub Actions logs
2. Check your backend hosting platform logs
3. Verify all URLs and environment variables are correct

