# Quick Start Guide - Deploy to www.techproject.in

This is a simplified deployment guide. For full details, see [DEPLOYMENT.md](DEPLOYMENT.md).

## ⚡ Fastest Method: GitHub Pages

### Step 1: Enable GitHub Pages (2 minutes)

1. Go to: https://github.com/roger-44/Weather/settings/pages
2. Under **Source**:
   - Branch: `main` (or `master`)
   - Folder: `/ (root)`
   - Click **Save**
3. Under **Custom domain**: Enter `www.techproject.in` and click **Save**
4. Check **Enforce HTTPS**

### Step 2: Configure DNS (5 minutes)

Go to your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.) and add:

```
Type: CNAME
Name: www
Value: roger-44.github.io
TTL: 3600 (or Auto)
```

### Step 3: Wait for Deployment

- GitHub deployment: ~2-5 minutes (check Actions tab)
- DNS propagation: 24-48 hours
- Check status: https://www.whatsmydns.net/

### Step 4: Visit Your Site

After DNS propagates, visit: **https://www.techproject.in** 🎉

---

## 🔧 Alternative: Manual Upload

If you have web hosting with FTP/cPanel:

### Using deploy.sh Script

```bash
./deploy.sh
```

Follow the prompts to:
- Upload via FTP
- Create a deployment package
- Check deployment status

### Manual Upload

1. Connect to FTP: `ftp.techproject.in`
2. Upload `index.html` to `public_html/` directory
3. Upload `.htaccess` (optional, for Apache servers)
4. Visit: http://www.techproject.in

---

## ✅ Post-Deployment Checklist

After deployment:

- [ ] Visit https://www.techproject.in
- [ ] Test location detection
- [ ] Test city search
- [ ] Check mobile responsiveness
- [ ] Add OpenWeatherMap API key for live data (replace `DEMO_KEY` in index.html)
- [ ] Verify HTTPS is working

---

## 📱 Add Your API Key

For real weather data:

1. Get free API key: https://openweathermap.org/api
2. Edit `index.html` line 378:
   ```javascript
   const API_KEY = 'your_api_key_here';
   ```
3. Re-upload/push to GitHub

---

## 🆘 Troubleshooting

**Site not loading?**
- Wait 24-48 hours for DNS propagation
- Clear browser cache (Ctrl+Shift+Delete)
- Try incognito mode

**"Not Secure" warning?**
- Enable "Enforce HTTPS" in GitHub Pages settings
- Wait 24 hours for SSL certificate

**Weather not updating?**
- Replace `DEMO_KEY` with real API key
- Check browser console (F12) for errors

---

## 📚 Need Help?

- Full guide: [DEPLOYMENT.md](DEPLOYMENT.md)
- Issues: https://github.com/roger-44/Weather/issues
- DNS checker: https://www.whatsmydns.net/

---

**Total setup time**: ~7 minutes (+ DNS wait time)
