#!/bin/bash

# Deployment script for www.techproject.in
# This script helps deploy the weather app to your web hosting

echo "=================================="
echo "Weather App Deployment Script"
echo "Target: www.techproject.in"
echo "=================================="
echo ""

# Check if index.html exists
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found!"
    echo "Please run this script from the repository root directory."
    exit 1
fi

echo "✅ Found index.html"
echo ""

# Deployment options
echo "Select deployment method:"
echo "1) GitHub Pages (recommended)"
echo "2) FTP/SFTP"
echo "3) Create deployment package (zip)"
echo "4) Show deployment status"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo "📦 GitHub Pages Deployment"
        echo "------------------------"
        echo "Steps to deploy via GitHub Pages:"
        echo ""
        echo "1. Go to: https://github.com/roger-44/Weather/settings/pages"
        echo "2. Under 'Source', select 'Deploy from a branch'"
        echo "3. Select branch: main (or master)"
        echo "4. Select folder: / (root)"
        echo "5. Click 'Save'"
        echo "6. Under 'Custom domain', enter: www.techproject.in"
        echo "7. Check 'Enforce HTTPS'"
        echo ""
        echo "Then configure DNS at your domain registrar:"
        echo "  Type: CNAME"
        echo "  Name: www"
        echo "  Value: roger-44.github.io"
        echo ""
        echo "See DEPLOYMENT.md for detailed instructions."
        ;;
    2)
        echo ""
        echo "📡 FTP/SFTP Deployment"
        echo "--------------------"
        read -p "FTP Host (e.g., ftp.techproject.in): " ftp_host
        read -p "FTP Username: " ftp_user
        read -sp "FTP Password: " ftp_pass
        echo ""
        read -p "Remote directory (e.g., /public_html): " remote_dir
        
        echo ""
        echo "Testing FTP connection..."
        
        # Check if lftp is installed
        if command -v lftp &> /dev/null; then
            echo "Uploading files via FTP..."
            lftp -u "$ftp_user,$ftp_pass" "$ftp_host" <<EOF
cd $remote_dir
put index.html
put .htaccess
put DEPLOYMENT.md
put README.md
bye
EOF
            echo "✅ Deployment complete!"
            echo "Visit: https://www.techproject.in"
        else
            echo "❌ lftp not installed."
            echo "Please install lftp: sudo apt-get install lftp"
            echo "Or use FileZilla to manually upload:"
            echo "  - index.html"
            echo "  - .htaccess"
            echo "  - README.md"
        fi
        ;;
    3)
        echo ""
        echo "📦 Creating deployment package..."
        
        # Create a deployment zip
        zip_name="weather-app-deployment-$(date +%Y%m%d-%H%M%S).zip"
        zip -r "$zip_name" index.html .htaccess README.md DEPLOYMENT.md -x "*.git*"
        
        echo "✅ Package created: $zip_name"
        echo ""
        echo "Upload this file to your hosting:"
        echo "1. Log in to cPanel"
        echo "2. Open File Manager"
        echo "3. Navigate to public_html"
        echo "4. Upload $zip_name"
        echo "5. Extract the archive"
        echo "6. Visit https://www.techproject.in"
        ;;
    4)
        echo ""
        echo "🔍 Checking deployment status..."
        echo ""
        
        # Check if site is accessible
        echo "Testing www.techproject.in..."
        if curl -sI https://www.techproject.in | head -n 1 | grep -q "200\|301\|302"; then
            echo "✅ Site is live at https://www.techproject.in"
        else
            echo "⚠️  Site not accessible yet"
            echo "   - DNS may still be propagating (wait 24-48 hours)"
            echo "   - Or deployment not complete"
        fi
        
        echo ""
        echo "Testing techproject.in..."
        if curl -sI https://techproject.in | head -n 1 | grep -q "200\|301\|302"; then
            echo "✅ Site is live at https://techproject.in"
        else
            echo "⚠️  Apex domain not accessible yet"
        fi
        
        echo ""
        echo "DNS Status:"
        nslookup www.techproject.in 2>/dev/null || echo "⚠️  DNS not configured"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo ""
echo "=================================="
echo "For detailed instructions, see:"
echo "  📖 DEPLOYMENT.md"
echo "=================================="
