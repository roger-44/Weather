# Deployment Guide for www.techproject.in

This guide covers multiple deployment options for deploying the Weather App to **www.techproject.in**.

## Table of Contents
1. [GitHub Pages Deployment (Recommended)](#github-pages-deployment)
2. [Traditional Web Hosting Deployment](#traditional-web-hosting)
3. [Cloud Platform Deployment](#cloud-platform-deployment)
4. [DNS Configuration](#dns-configuration)

---

## GitHub Pages Deployment (Recommended)

GitHub Pages is the easiest and most cost-effective solution for static websites.

### Prerequisites
- GitHub account with this repository
- Access to your domain's DNS settings

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub: `https://github.com/roger-44/Weather`
2. Click on **Settings** → **Pages**
3. Under **Source**, select:
   - Source: `Deploy from a branch`
   - Branch: `main` (or `master`)
   - Folder: `/ (root)`
4. Click **Save**

### Step 2: Verify GitHub Actions

The repository includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that automatically deploys your site when you push changes.

1. Go to **Actions** tab in your repository
2. You should see the "Deploy to GitHub Pages" workflow
3. If it hasn't run, click **Run workflow** manually

### Step 3: Configure Custom Domain

1. In GitHub Pages settings, under **Custom domain**, enter: `www.techproject.in`
2. Click **Save**
3. Check **Enforce HTTPS** (recommended for security)

The `CNAME` file in this repository will ensure the custom domain is maintained across deployments.

### Step 4: Configure DNS Settings

See [DNS Configuration](#dns-configuration) section below.

### Verification

Once DNS propagates (can take 24-48 hours), your site will be live at:
- https://www.techproject.in
- The site will have a free SSL certificate from Let's Encrypt

---

## Traditional Web Hosting Deployment

If you have traditional web hosting (cPanel, FTP access), follow these steps.

### Prerequisites
- FTP/SFTP credentials from your hosting provider
- Access to cPanel or hosting control panel

### Option 1: FTP Upload

1. **Connect to your hosting via FTP** using FileZilla or similar:
   - Host: `ftp.techproject.in` (or your hosting provider's FTP server)
   - Username: Your FTP username
   - Password: Your FTP password
   - Port: 21 (FTP) or 22 (SFTP)

2. **Navigate to your web root directory**:
   - Usually named: `public_html`, `www`, `htdocs`, or `public`

3. **Upload files**:
   - Upload `index.html` to the root directory
   - Upload `README.md` (optional)
   - Upload `.htaccess` if using Apache (see below)

4. **Set permissions** (if needed):
   - Files: 644
   - Directories: 755

### Option 2: cPanel File Manager

1. Log in to your cPanel account
2. Open **File Manager**
3. Navigate to `public_html` directory
4. Click **Upload** and select `index.html`
5. Wait for upload to complete

### Apache Configuration (.htaccess)

Create a `.htaccess` file in your web root if using Apache:

```apache
# Enable HTTPS redirect
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Set default page
DirectoryIndex index.html

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Browser caching
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/html "access plus 1 hour"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
</IfModule>

# Security headers
<IfModule mod_headers.c>
    Header set X-Content-Type-Options "nosniff"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-XSS-Protection "1; mode=block"
</IfModule>
```

### Verification

Open your browser and navigate to:
- http://www.techproject.in
- http://techproject.in

Both should work if DNS is configured correctly.

---

## Cloud Platform Deployment

### Netlify

1. **Sign up at** [Netlify](https://www.netlify.com)
2. **Connect your GitHub repository**:
   - Click "New site from Git"
   - Choose GitHub and select `roger-44/Weather`
   - Build settings:
     - Build command: (leave empty)
     - Publish directory: `/`
3. **Configure custom domain**:
   - Site settings → Domain management
   - Add custom domain: `www.techproject.in`
   - Follow DNS instructions

### Vercel

1. **Sign up at** [Vercel](https://vercel.com)
2. **Import project**:
   - Click "New Project"
   - Import from GitHub: `roger-44/Weather`
   - Framework preset: Other
   - Root directory: `/`
3. **Add custom domain**:
   - Project settings → Domains
   - Add `www.techproject.in`
   - Configure DNS as instructed

### AWS S3 + CloudFront

1. **Create S3 bucket**:
   - Name: `www.techproject.in`
   - Enable static website hosting
   - Upload `index.html`

2. **Create CloudFront distribution**:
   - Origin: Your S3 bucket
   - Alternate domain names: `www.techproject.in`
   - SSL certificate: Use ACM certificate

3. **Configure Route 53**:
   - Create hosted zone for `techproject.in`
   - Add A record for `www` pointing to CloudFront

---

## DNS Configuration

You need to configure DNS settings with your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.).

### For GitHub Pages

Add these DNS records at your domain registrar:

#### Option 1: CNAME (Recommended)
```
Type: CNAME
Name: www
Value: roger-44.github.io
TTL: 3600 (or Auto)
```

#### Option 2: A Records (Apex Domain)
If you want both `techproject.in` and `www.techproject.in` to work:

```
Type: A
Name: @
Value: 185.199.108.153
TTL: 3600

Type: A
Name: @
Value: 185.199.109.153
TTL: 3600

Type: A
Name: @
Value: 185.199.110.153
TTL: 3600

Type: A
Name: @
Value: 185.199.111.153
TTL: 3600

Type: CNAME
Name: www
Value: roger-44.github.io
TTL: 3600
```

### For Traditional Hosting

Get the IP address from your hosting provider and create an A record:

```
Type: A
Name: @
Value: [Your hosting IP address]
TTL: 3600

Type: A
Name: www
Value: [Your hosting IP address]
TTL: 3600
```

Or use CNAME:
```
Type: CNAME
Name: www
Value: [Your hosting domain]
TTL: 3600
```

### DNS Propagation

- DNS changes can take **24-48 hours** to propagate worldwide
- Use tools like [WhatsMyDNS](https://www.whatsmydns.net/) to check propagation
- Clear your browser cache after DNS updates

---

## SSL/HTTPS Configuration

### GitHub Pages
- Automatic SSL certificate via Let's Encrypt
- Enable "Enforce HTTPS" in GitHub Pages settings

### Traditional Hosting
- cPanel: Use "SSL/TLS Status" to install Let's Encrypt certificate
- Or request SSL certificate from your hosting provider

### Cloud Platforms
- Netlify/Vercel: Automatic HTTPS
- AWS: Use AWS Certificate Manager (ACM)

---

## Deployment Checklist

- [ ] Choose deployment method (GitHub Pages recommended)
- [ ] Configure GitHub Pages or upload files to hosting
- [ ] Add custom domain in hosting settings
- [ ] Configure DNS records at domain registrar
- [ ] Wait for DNS propagation (24-48 hours)
- [ ] Enable HTTPS/SSL
- [ ] Test website at www.techproject.in
- [ ] Verify responsive design on mobile/desktop
- [ ] Test weather functionality (add API key if using live data)

---

## Getting Your OpenWeatherMap API Key

For live weather data:

1. Sign up at [OpenWeatherMap](https://openweathermap.org/api)
2. Get your free API key (1000 calls/day)
3. Edit `index.html` line 378: Replace `DEMO_KEY` with your API key
4. Re-deploy the updated file

---

## Troubleshooting

### Site not loading after 48 hours
- Verify DNS records are correct using `nslookup www.techproject.in`
- Check GitHub Pages deployment status in Actions tab
- Clear browser cache and try incognito mode

### SSL certificate error
- Ensure "Enforce HTTPS" is enabled in GitHub Pages
- Wait 24 hours after domain configuration for certificate

### Weather data not loading
- Replace `DEMO_KEY` with actual OpenWeatherMap API key
- Check browser console for API errors (F12)
- Verify API key is activated (can take 2 hours)

### 404 Error
- Ensure `index.html` is in the root directory
- Check GitHub Pages source branch is correct
- Verify CNAME file contains `www.techproject.in`

---

## Support

For issues:
1. Check [GitHub Issues](https://github.com/roger-44/Weather/issues)
2. Review GitHub Pages documentation
3. Contact your hosting provider for traditional hosting issues

---

## Quick Start (GitHub Pages)

The fastest way to deploy:

```bash
# 1. Enable GitHub Pages in repository settings
# 2. Add this DNS record at your domain registrar:
Type: CNAME
Name: www
Value: roger-44.github.io

# 3. Wait 24-48 hours for DNS propagation
# 4. Visit https://www.techproject.in
```

Done! Your weather app is now live! 🎉
