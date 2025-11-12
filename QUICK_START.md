# Quick Start - Deploy Kuba UI Hub

## 🚀 Quick Deployment Steps

### 1. Enable GitHub Pages (One-time setup)

1. Go to your GitHub repository
2. **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**
4. Save

> 📖 **Need detailed steps?** See [GITHUB_PAGES_SETUP.md](./GITHUB_PAGES_SETUP.md) for a complete guide with screenshots descriptions.

### 2. Update Repository Name (if needed)

If your repository is NOT named `kuba_ui_hub`, update the workflow:

Edit `.github/workflows/deploy-web.yml` line 48:
```yaml
flutter build web --release --base-href "/YOUR_REPO_NAME/" --dart-define=API_BASE_URL="$API_BASE_URL"
```

### 3. Deploy Backend (Choose one)

#### Option A: Render.com (Recommended)
1. Sign up at [render.com](https://render.com)
2. New → Web Service
3. Connect GitHub repo
4. Root Directory: `backend`
5. Build: `npm install`
6. Start: `npm start`
7. Copy your backend URL (e.g., `https://kuba-ui-hub-backend.onrender.com`)

#### Option B: Railway.app
1. Sign up at [railway.app](https://railway.app)
2. New Project → Deploy from GitHub
3. Select `backend` folder
4. Copy your backend URL

> 📖 **Need detailed step-by-step instructions?** See [BACKEND_DEPLOYMENT.md](./BACKEND_DEPLOYMENT.md) for complete guides with all the details.

### 4. Configure Backend URL in GitHub

1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `API_BASE_URL`
4. Value: Your backend URL (e.g., `https://kuba-ui-hub-backend.onrender.com`)
5. Save

> 📖 **Detailed instructions** are also in [BACKEND_DEPLOYMENT.md](./BACKEND_DEPLOYMENT.md) under "After Deployment: Configure GitHub Secret"

### 5. Deploy!

```bash
git add .
git commit -m "Setup deployment"
git push origin main
```

### 6. Access Your App

After the GitHub Action completes (check the **Actions** tab):
- Your app: `https://YOUR_USERNAME.github.io/kuba_ui_hub/`
- Your backend: `https://your-backend-url.onrender.com`

## 📱 App Features

- **Mobile-first design**: Displays in iPhone 16 Pro Max frame (430x932px) on desktop
- **Full-screen on mobile**: Automatically adapts to smaller screens
- **GitHub Pages**: Free hosting with HTTPS
- **Auto-deploy**: Pushes to `main` branch automatically deploy

## 🔧 Troubleshooting

**CORS errors?**
- Update `backend/server.js` with your GitHub Pages URL in `allowedOrigins`

**404 errors?**
- Check that `--base-href` matches your repository name
- Verify GitHub Pages source is set to "GitHub Actions"

**Backend not working?**
- Check backend logs on your hosting platform
- Verify `API_BASE_URL` secret is set correctly in GitHub

## 📚 Full Documentation

See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed instructions.

