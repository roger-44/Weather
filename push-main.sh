#!/bin/bash
# Script to push main branch and trigger deployment

echo "======================================"
echo "Weather App - Deploy to Main Branch"
echo "======================================"
echo ""

# Check if on main branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "⚠️  Currently on branch: $CURRENT_BRANCH"
    echo "Switching to main branch..."
    git checkout main
    if [ $? -ne 0 ]; then
        echo "❌ Failed to switch to main branch"
        exit 1
    fi
fi

echo "✅ On main branch"
echo ""

# Show current status
echo "📊 Current Status:"
git log --oneline -3
echo ""

# Show what will be pushed
echo "📤 Commits to push:"
git log origin/main..main --oneline 2>/dev/null || echo "Main branch will be created on remote"
echo ""

# Confirm push
echo "This will push the main branch to GitHub and trigger deployment."
read -p "Continue? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Pushing to origin/main..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Successfully pushed to main branch!"
        echo ""
        echo "🚀 GitHub Actions will now deploy your site"
        echo "📍 Check deployment status at:"
        echo "   https://github.com/roger-44/Weather/actions"
        echo ""
        echo "🌐 Your site will be live at:"
        echo "   https://roger-44.github.io/Weather"
        echo "   https://www.techproject.in (if DNS configured)"
    else
        echo ""
        echo "❌ Push failed. Check your credentials and try again."
        echo "   You may need to use GitHub token authentication."
    fi
else
    echo "Push cancelled."
fi
