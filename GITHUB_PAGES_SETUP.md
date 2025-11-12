# How to Enable GitHub Pages with GitHub Actions

Follow these steps to configure GitHub Pages to use GitHub Actions as the source.

## Step-by-Step Guide

### Step 1: Navigate to Your Repository
1. Go to [GitHub.com](https://github.com) and sign in
2. Open your repository: `kuba_ui_hub` (or your repository name)

### Step 2: Open Repository Settings
1. Click on the **Settings** tab at the top of your repository
   - It's located in the horizontal menu: `Code` | `Issues` | `Pull requests` | `Actions` | `Projects` | `Wiki` | `Security` | `Settings`
   - You need to be the repository owner or have admin access to see this tab

### Step 3: Find Pages Settings
1. In the left sidebar, scroll down to find **Pages**
   - It's under the "Code and automation" section
   - Click on **Pages**

### Step 4: Configure the Source
1. You'll see a section called **"Build and deployment"**
2. Under **"Source"**, you'll see a dropdown menu
3. Click the dropdown and select **"GitHub Actions"**
   - ⚠️ **Important**: Do NOT select "Deploy from a branch"
   - Select **"GitHub Actions"** instead

### Step 5: Save
1. The selection should save automatically
2. You should see a message confirming the configuration

## Visual Guide

```
Repository → Settings → Pages → Source: GitHub Actions
```

## What You Should See

After selecting "GitHub Actions", you should see:
- **Source**: GitHub Actions (selected)
- A note that says: "Your site is ready to be published at `https://YOUR_USERNAME.github.io/kuba_ui_hub/`"
- The URL will be available after your first successful workflow run

## Important Notes

1. **No branch selection needed**: When using GitHub Actions, you don't need to select a branch
2. **Workflow must run first**: The URL won't be active until your GitHub Actions workflow completes successfully
3. **Check Actions tab**: After pushing code, check the **Actions** tab to see the deployment progress

## Troubleshooting

### Can't see the Settings tab?
- Make sure you're the repository owner or have admin permissions
- If it's a fork, you may need to make it your own repository

### "GitHub Actions" option not available?
- Make sure you have the workflow file in `.github/workflows/deploy-web.yml`
- The option appears once GitHub detects workflow files

### Still having issues?
1. Make sure the workflow file exists: `.github/workflows/deploy-web.yml`
2. Check that you have the correct permissions
3. Try refreshing the page

## Next Steps

After configuring GitHub Pages:
1. Push your code to trigger the workflow
2. Go to the **Actions** tab to monitor the deployment
3. Once complete, visit your site at: `https://YOUR_USERNAME.github.io/kuba_ui_hub/`

## Alternative: If You Don't See "GitHub Actions" Option

If the "GitHub Actions" option doesn't appear:
1. Make sure you've committed and pushed the workflow file (`.github/workflows/deploy-web.yml`)
2. Wait a few minutes and refresh the Settings page
3. If it still doesn't appear, you can temporarily use "Deploy from a branch" and select `gh-pages` branch, then switch back to GitHub Actions once the workflow creates the branch

