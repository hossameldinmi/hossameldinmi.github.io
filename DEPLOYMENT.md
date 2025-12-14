# GitHub Pages Deployment Guide

## Understanding GitHub Pages URL Structure

GitHub Pages serves websites differently based on the repository name:

### User/Organization Site (Root Domain)
- **Repository Name**: Must be `username.github.io` (e.g., `hossameldinmi.github.io`)
- **URL**: `https://username.github.io/`
- **Base Href**: `/`
- **Example**: `https://hossameldinmi.github.io/`

### Project Site (Subdirectory)
- **Repository Name**: Any name (e.g., `website`, `portfolio`, `my-app`)
- **URL**: `https://username.github.io/repository-name/`
- **Base Href**: `/repository-name/`
- **Example**: `https://hossameldinmi.github.io/website/`

## Current Configuration

This project is currently configured for **root domain deployment**:

- **Base Href in Workflow**: `--base-href "/"`
- **Base Href in Deploy Script**: `--base-href "/"`
- **Expected URL**: `https://hossameldinmi.github.io/`

## How to Deploy at Root Domain

To deploy your site at the root domain (`https://hossameldinmi.github.io/`), follow these steps:

### Step 1: Rename the Repository

1. Go to your repository on GitHub: `https://github.com/hossameldinmi/website`
2. Click **Settings** in the top menu
3. In the **General** section, find **Repository name**
4. Change the name from `website` to `hossameldinmi.github.io`
5. Click **Rename** button
6. Confirm the rename

### Step 2: Update Local Repository

After renaming on GitHub, update your local repository:

**Option 1: Use the helper script (Recommended)**
```bash
./update-after-rename.sh
```

**Option 2: Manual update**
```bash
# Update the remote URL
git remote set-url origin https://github.com/hossameldinmi/hossameldinmi.github.io.git

# Verify the change
git remote -v
```

### Step 3: Verify Deployment

1. Push any change to trigger deployment (or manually trigger workflow)
2. Go to **Actions** tab and wait for workflow to complete
3. Visit `https://hossameldinmi.github.io/` - your site should be live!

## Alternative: Deploy to Project Path

If you prefer to keep the repository name as `website` and deploy to `https://hossameldinmi.github.io/website/`:

### Option 1: Update Build Configuration

Change the base href in both files:

**File: `.github/workflows/deploy.yml` (line 35)**
```yaml
      - name: Build web
        run: flutter build web --release --base-href "/website/"
```

**File: `deploy.sh` (line 26)**
```bash
flutter build web --release --base-href "/website/"
```

### Option 2: Use Custom Domain

If you own a custom domain (e.g., `example.com`):

1. Add a `CNAME` file to the `web/` directory:
   ```bash
   echo "your-domain.com" > web/CNAME
   ```

2. Configure your domain's DNS:
   - Add a `CNAME` record pointing to `hossameldinmi.github.io`
   - Or add `A` records pointing to GitHub Pages IPs

3. In GitHub repository settings:
   - Go to **Settings** → **Pages**
   - Enter your custom domain
   - Enable **Enforce HTTPS**

4. Keep base href as `/` in configuration

## Verification Checklist

After making changes, verify:

- [ ] Repository is renamed to `hossameldinmi.github.io` (for root domain)
- [ ] Base href in `.github/workflows/deploy.yml` matches your deployment path
- [ ] Base href in `deploy.sh` matches your deployment path
- [ ] GitHub Pages is enabled in repository settings
- [ ] Workflow completes successfully in Actions tab
- [ ] Site is accessible at expected URL
- [ ] All assets (images, icons, fonts) load correctly
- [ ] All navigation links work properly

## Common Issues

### Assets Not Loading

**Symptom**: Website loads but images/fonts are broken

**Cause**: Base href mismatch - configuration has `/` but site is deployed to `/website/`

**Fix**: Either rename repository to `username.github.io` OR update base href to `/website/`

### 404 Error on Direct Route Access

**Symptom**: Homepage works but direct navigation to routes returns 404

**Cause**: GitHub Pages doesn't support client-side routing by default

**Fix**: Add a `404.html` that redirects to `index.html` (for single-page apps)

### Site Not Updating

**Symptom**: Changes pushed but site shows old content

**Fixes**:
1. Check Actions tab - verify workflow succeeded
2. Clear browser cache
3. Wait 2-5 minutes for CDN propagation
4. Try incognito/private browsing mode

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [Configuring GitHub Pages Source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)
