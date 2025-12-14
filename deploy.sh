#!/bin/bash

# Flutter Web Deployment Script for GitHub Pages
# This script builds and deploys your Flutter web app to GitHub Pages

set -e

echo "🚀 Starting deployment process..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build for web
echo "🔨 Building Flutter web app..."
flutter build web --release --base-href "/"

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Build failed. build/web directory not found."
    exit 1
fi

echo "✅ Build completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. The build is in the 'build/web' directory"
echo "2. Commit and push your code to GitHub:"
echo "   git add ."
echo "   git commit -m 'Update website'"
echo "   git push origin main"
echo "3. GitHub Actions will automatically deploy to Pages"
echo ""
echo "🌐 Your site will be available at:"
echo "   https://hossameldinmi.github.io/"
