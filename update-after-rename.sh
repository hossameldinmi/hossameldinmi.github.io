#!/bin/bash

# Repository Rename Helper Script
# 
# Purpose: Update local git configuration after renaming repository on GitHub
# Usage: ./update-after-rename.sh
#
# This script should be run AFTER renaming the repository on GitHub 
# from "website" to "hossameldinmi.github.io"
#
# What it does:
# - Prompts for confirmation that GitHub rename is complete
# - Updates the git remote URL to match the new repository name
# - Verifies the remote configuration

# Exit immediately if any command exits with a non-zero status
set -e

echo "=========================================="
echo "Repository Rename Helper Script"
echo "=========================================="
echo ""
echo "⚠️  IMPORTANT: This script assumes you have already renamed the repository on GitHub!"
echo ""
echo "Steps to rename repository on GitHub:"
echo "1. Go to: https://github.com/hossameldinmi/website"
echo "2. Click 'Settings' in the top menu"
echo "3. Find 'Repository name' section"
echo "4. Change name from 'website' to 'hossameldinmi.github.io'"
echo "5. Click 'Rename'"
echo ""
read -p "Have you completed the rename on GitHub? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Please rename the repository on GitHub first, then run this script again."
    exit 1
fi

echo ""
echo "✅ Updating local repository configuration..."
echo ""

# Extract current username from git remote
CURRENT_REMOTE=$(git remote get-url origin)
USERNAME=$(echo "$CURRENT_REMOTE" | sed -E 's|.*github\.com[:/]([^/]+)/.*|\1|')

if [ -z "$USERNAME" ]; then
    echo "❌ Could not detect GitHub username from remote URL"
    echo "Current remote: $CURRENT_REMOTE"
    exit 1
fi

echo "📝 Detected GitHub username: $USERNAME"
echo ""

# Update remote URL
echo "📝 Updating remote URL..."
git remote set-url origin "https://github.com/${USERNAME}/${USERNAME}.github.io.git"

# Verify the change
echo "✅ Remote URL updated!"
echo ""
echo "Current remote configuration:"
git remote -v

echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "Your repository is now configured for root domain deployment."
echo ""
echo "Next steps:"
echo "1. Push any change to trigger deployment:"
echo "   git add ."
echo "   git commit -m 'Update after repository rename'"
echo "   git push origin main"
echo ""
echo "2. Your site will be available at:"
echo "   https://${USERNAME}.github.io/"
echo ""
echo "3. Monitor deployment in the Actions tab:"
echo "   https://github.com/${USERNAME}/${USERNAME}.github.io/actions"
echo ""
