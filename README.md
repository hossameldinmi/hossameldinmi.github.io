# Professional CV Website

A modern, responsive CV/Portfolio website built with Flutter Web.

## 🌐 Live Demo

Visit the live website at: [https://hossameldinmi.github.io](https://hossameldinmi.github.io)

## 🚀 Deployment to GitHub Pages

### Method 1: Automatic Deployment (Recommended)

The website automatically deploys to GitHub Pages when you push to the `main` branch.

1. **Commit your changes:**
   ```bash
   git add .
   git commit -m "Update website content"
   git push origin main
   ```

2. **GitHub Actions will automatically:**
   - Build your Flutter web app
   - Deploy to GitHub Pages
   - Your site will be live in 2-3 minutes

3. **Enable GitHub Pages (First time only):**
   - Go to your repository on GitHub
   - Click **Settings** → **Pages**
   - Under **Source**, select **GitHub Actions**
   - The workflow will automatically deploy on the next push

### Method 2: Manual Deployment

Use the deployment script:

```bash
./deploy.sh
```

Then push the changes:

```bash
git add .
git commit -m "Deploy website"
git push origin main
```

### Method 3: Manual Build and Deploy

```bash
# Build the web app
flutter build web --release --base-href "/"

# The build output is in build/web/
# Push to GitHub and the workflow will deploy it
```

## 📝 Updating Content

All resume data is centralized in `lib/resume_data.dart`. To update:

1. Edit `lib/resume_data.dart`
2. Save the file
3. Commit and push to GitHub
4. The site will auto-deploy with your changes

## 🛠️ Local Development

```bash
# Install dependencies
flutter pub get

# Run locally
flutter run -d chrome

# Or specify a port
flutter run -d chrome --web-port=8080
```

## 📦 Project Structure

```
lib/
├── main.dart          # Main application and UI
└── resume_data.dart   # All resume/CV data

.github/
└── workflows/
    └── deploy.yml     # GitHub Actions deployment workflow

web/
└── index.html        # HTML entry point
```

## 🎨 Features

- ✅ Responsive design (mobile, tablet, desktop)
- ✅ Animated transitions and effects
- ✅ Professional summary section
- ✅ Skills showcase
- ✅ Work experience timeline
- ✅ Open-source projects portfolio
- ✅ Contact information with clickable links
- ✅ Auto-deployment to GitHub Pages

## 🔧 Technologies

- **Flutter** - UI framework
- **Dart** - Programming language
- **Google Fonts** - Typography
- **Animated Text Kit** - Text animations
- **GitHub Pages** - Hosting
- **GitHub Actions** - CI/CD

## 📄 License

© 2024 Hossam Eldin Mahmoud. All rights reserved.

## 🤝 Contact

- Email: hossameldinmi@gmail.com
- LinkedIn: [linkedin.com/in/hossameldinmi](https://linkedin.com/in/hossameldinmi)
- GitHub: [github.com/hossameldinmi](https://github.com/hossameldinmi)