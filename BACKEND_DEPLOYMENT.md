# Backend Deployment Guide

This guide will walk you through deploying your Node.js backend to a free hosting service. Choose either **Render.com** or **Railway.app** - both offer free tiers.

---

## Option A: Deploy to Render.com (Recommended)

Render.com offers a free tier with automatic deployments from GitHub.

### Step 1: Sign Up for Render

1. Go to [render.com](https://render.com)
2. Click **"Get Started for Free"** or **"Sign Up"**
3. Sign up using:
   - **GitHub** (recommended - easiest integration)
   - Email address
   - Google account
4. Complete the signup process

### Step 2: Create a New Web Service

1. Once logged in, you'll see the Render dashboard
2. Click the **"New +"** button (usually in the top right or center)
3. Select **"Web Service"** from the dropdown menu

### Step 3: Connect Your GitHub Repository

1. Render will ask you to connect a repository
2. If you haven't connected GitHub yet:
   - Click **"Connect GitHub"** or **"Configure account"**
   - Authorize Render to access your repositories
   - Select the repositories you want to give access to (or all repositories)
3. Search for and select your `kuba_ui_hub` repository
4. Click **"Connect"**

### Step 4: Configure the Service

Fill in the following settings:

#### Basic Settings:
- **Name**: `kuba-ui-hub-backend` (or any name you prefer)
- **Region**: Choose the closest region to your users (e.g., `Oregon (US West)`)

#### Build & Deploy Settings:
- **Root Directory**: `backend`
  - ⚠️ **Important**: This tells Render to look in the `backend` folder
  - Click the folder icon and type `backend` or select it
  
- **Environment**: `Node`
  - Render should auto-detect this, but make sure it's set to Node

- **Build Command**: `npm install`
  - This installs all dependencies

- **Start Command**: `npm start`
  - This runs your server.js file

#### Plan:
- **Free**: Select the free plan (you can upgrade later if needed)

### Step 5: Environment Variables (Optional)

You can add environment variables if needed:
- Click **"Advanced"** or **"Environment Variables"**
- Add any variables your backend needs
- For this project, the defaults should work fine

### Step 6: Deploy

1. Scroll down and click **"Create Web Service"**
2. Render will start building and deploying your backend
3. You'll see a build log showing the progress:
   - Installing dependencies
   - Building the service
   - Starting the service

### Step 7: Get Your Backend URL

1. Once deployment completes (usually 2-5 minutes), you'll see:
   - **Status**: "Live" (green indicator)
   - **URL**: Something like `https://kuba-ui-hub-backend.onrender.com`
2. **Copy this URL** - you'll need it for the next step!

### Step 8: Test Your Backend

1. Open the URL in your browser
2. You should see: `{"message":"Welcome to Kuba UI Hub API",...}`
3. Test an endpoint: `https://your-backend.onrender.com/api/reviewers`

---

## Option B: Deploy to Railway.app

Railway.app also offers a free tier with easy GitHub integration.

### Step 1: Sign Up for Railway

1. Go to [railway.app](https://railway.app)
2. Click **"Start a New Project"** or **"Login"**
3. Sign up using:
   - **GitHub** (recommended)
   - Email address
4. Complete the signup process

### Step 2: Create a New Project

1. Once logged in, click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. If prompted, authorize Railway to access your GitHub account

### Step 3: Select Your Repository

1. Railway will show your GitHub repositories
2. Find and select `kuba_ui_hub`
3. Click on it to proceed

### Step 4: Configure the Service

1. Railway will detect your repository structure
2. You need to configure it to use the `backend` folder:
   - Click on the service that was created
   - Go to **Settings** tab
   - Under **"Root Directory"**, enter: `backend`
   - Save changes

### Step 5: Configure Build Settings

Railway should auto-detect Node.js, but verify:
1. Go to the **Settings** tab
2. Check that:
   - **Build Command**: `npm install` (or leave empty - Railway auto-detects)
   - **Start Command**: `npm start`
   - **Node Version**: Auto-detected (or specify if needed)

### Step 6: Deploy

1. Railway will automatically start deploying
2. Watch the **Deployments** tab to see progress
3. The deployment usually takes 2-5 minutes

### Step 7: Get Your Backend URL

1. Once deployed, go to the **Settings** tab
2. Under **"Networking"**, you'll see:
   - **Generate Domain**: Click this to get a public URL
   - Or Railway may auto-generate one
3. Your URL will look like: `https://kuba-ui-hub-backend.up.railway.app`
4. **Copy this URL** - you'll need it!

### Step 8: Test Your Backend

1. Open the URL in your browser
2. You should see the API welcome message
3. Test an endpoint: `https://your-backend.up.railway.app/api/reviewers`

---

## After Deployment: Configure GitHub Secret

Now that you have your backend URL, you need to tell your Flutter app where to find it:

### Step 1: Go to GitHub Repository Settings

1. Open your `kuba_ui_hub` repository on GitHub
2. Click **Settings** (top menu)
3. In the left sidebar, click **Secrets and variables** → **Actions**

### Step 2: Add the Backend URL Secret

1. Click **"New repository secret"**
2. **Name**: `API_BASE_URL`
   - ⚠️ Must be exactly this name (case-sensitive)
3. **Secret**: Paste your backend URL
   - Example: `https://kuba-ui-hub-backend.onrender.com`
   - Or: `https://kuba-ui-hub-backend.up.railway.app`
4. Click **"Add secret"**

### Step 3: Verify

You should now see `API_BASE_URL` in your secrets list. This will be used automatically when your GitHub Actions workflow builds your Flutter app.

---

## Troubleshooting

### Backend Not Starting

**Check the logs:**
- **Render**: Go to your service → **Logs** tab
- **Railway**: Go to your service → **Deployments** → Click on the latest deployment → View logs

**Common issues:**
- **Port error**: Make sure your `server.js` uses `process.env.PORT || 3000`
- **Database error**: The SQLite database should be created automatically
- **Missing dependencies**: Check that `package.json` has all required packages

### CORS Errors

If you see CORS errors when testing:
1. The backend CORS is already configured in `server.js`
2. Make sure your GitHub Pages URL is allowed
3. Update `backend/server.js` if needed (see DEPLOYMENT.md)

### Cold Start Delays

Free tiers may have "cold starts":
- First request after inactivity may take 30-60 seconds
- This is normal for free hosting
- Consider upgrading to paid tier for production

### Database Issues

The SQLite database file (`kuba_hub.db`) is created automatically on first run. If you need to reset it:
1. Delete the database file in your hosting platform
2. Redeploy - it will be recreated

---

## Comparison: Render vs Railway

| Feature | Render.com | Railway.app |
|---------|-----------|-------------|
| **Free Tier** | ✅ Yes | ✅ Yes |
| **Auto-deploy from GitHub** | ✅ Yes | ✅ Yes |
| **Custom Domain** | ✅ Free | ✅ Free |
| **HTTPS** | ✅ Automatic | ✅ Automatic |
| **Cold Starts** | ⚠️ Possible | ⚠️ Possible |
| **Ease of Setup** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Documentation** | Excellent | Good |

**Recommendation**: Both are great options. Render.com is slightly easier for first-time setup.

---

## Next Steps

After deploying your backend:

1. ✅ Backend is deployed and running
2. ✅ Backend URL is added to GitHub Secrets
3. ✅ Push your code to trigger Flutter web deployment
4. ✅ Your app will automatically connect to your backend!

See [QUICK_START.md](./QUICK_START.md) for the complete deployment flow.

