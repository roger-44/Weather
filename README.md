# Weather Detection Website

A modern, responsive weather application powered by **[www.techproject.in](https://www.techproject.in)** that detects your location and displays comprehensive weather information including temperature, wind speed, rain probability, air quality, and local time.

## Features

- 🌍 **Automatic Location Detection**: Uses browser geolocation API to detect your current location
- 🔍 **Manual Location Search**: Search for any city worldwide
- 🌡️ **Temperature Display**: Current temperature and "feels like" temperature
- 💨 **Wind Speed**: Real-time wind speed information
- 🌧️ **Rain Probability**: Calculates probability of rain in the next 24 hours
- 🌫️ **Air Quality Index**: Displays AQI and pollutant levels (CO, NO₂, O₃, PM2.5, PM10)
- 🕐 **Local Time**: Shows current time for the selected location
- 📍 **Geographic Coordinates**: Displays latitude and longitude
- 📊 **Additional Metrics**: Humidity, pressure, visibility, and cloudiness

## How to Use

### Option 1: Demo Mode (No Setup Required)
Simply open `index.html` in your web browser. The app will display demo data by default.

### Option 2: Live Weather Data (Recommended)

1. **Get an API Key**:
   - Visit [OpenWeatherMap](https://openweathermap.org/api)
   - Sign up for a free account
   - Get your API key from the dashboard

2. **Configure the App**:
   - Open `index.html` in a text editor
   - Find the line: `const API_KEY = 'DEMO_KEY';`
   - Replace `'DEMO_KEY'` with your actual API key: `const API_KEY = 'your_api_key_here';`
   - Save the file

3. **Run the App**:
   - Open `index.html` in your web browser
   - Click "Detect Location" to use your current location (requires location permission)
   - Or enter a city name and click "Search"

## Features in Detail

### Weather Information
- **Current Temperature**: Displayed in Celsius with large, easy-to-read format
- **Weather Description**: Clear description of current weather conditions
- **Feels Like Temperature**: Perceived temperature based on humidity and wind

### Wind & Atmospheric Data
- **Wind Speed**: Measured in meters per second (m/s)
- **Humidity**: Relative humidity percentage
- **Pressure**: Atmospheric pressure in hPa
- **Visibility**: Visual range in kilometers
- **Cloudiness**: Cloud coverage percentage

### Rain Forecast
- Analyzes the next 24 hours of forecast data
- Calculates probability percentage based on weather predictions

### Air Quality
- **AQI Rating**: Displays air quality from Good to Hazardous
- **Pollutant Breakdown**: Shows levels of:
  - CO (Carbon Monoxide)
  - NO₂ (Nitrogen Dioxide)
  - O₃ (Ozone)
  - PM2.5 (Fine Particulate Matter)
  - PM10 (Coarse Particulate Matter)

### Time Display
- Shows local time for the selected location
- Automatically adjusts for timezone differences

## Technology Stack

- **HTML5**: Semantic markup and structure
- **CSS3**: Modern styling with gradients, flexbox, and grid layouts
- **JavaScript**: Vanilla JS for API integration and DOM manipulation
- **OpenWeatherMap API**: Weather data provider
  - Current Weather Data API
  - Air Pollution API
  - 5-Day Forecast API
- **Geolocation API**: Browser-based location detection

## Browser Compatibility

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Opera (latest)

## Responsive Design

The app is fully responsive and works on:
- 📱 Mobile phones
- 📱 Tablets
- 💻 Desktop computers

## Privacy

- Location data is only used to fetch weather information
- No data is stored or transmitted to third parties
- Location permission can be denied; manual search still works

## API Rate Limits

OpenWeatherMap free tier includes:
- 1,000 API calls per day
- 60 calls per minute
- Sufficient for personal use

## Troubleshooting

**Location Detection Not Working**:
- Ensure you've granted location permissions in your browser
- Try using manual search instead

**Weather Data Not Loading**:
- Check your API key is correctly configured
- Verify you have an active internet connection
- Ensure API key is activated (can take up to 2 hours for new keys)

**City Not Found**:
- Try different name variations (e.g., "NYC" vs "New York")
- Include country if results are unclear (e.g., "London, UK")

## License

This project is open source and available for personal and educational use.

---

**Powered by [www.techproject.in](https://www.techproject.in)** 🌐
