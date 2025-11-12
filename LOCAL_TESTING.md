# Local Testing Guide

Test your Flutter web app locally without deploying to GitHub Pages.

## Quick Start

### Option 1: Run in Chrome (Recommended)
```bash
cd flutter
flutter run -d chrome
```

This will:
- Build your web app
- Open it in Chrome automatically
- Enable hot reload (save files to see changes instantly)
- Show debug info in the browser console

### Option 2: Run with specific port
```bash
cd flutter
flutter run -d chrome --web-port=8080
```

Then open: `http://localhost:8080`

### Option 3: Build and serve manually
```bash
cd flutter
flutter build web
cd build/web
python3 -m http.server 8000
# Or if you have Node.js:
npx serve
```

Then open: `http://localhost:8000`

## Hot Reload

While `flutter run -d chrome` is running:
- Press `r` in the terminal to hot reload
- Press `R` to hot restart (full restart)
- Press `q` to quit

Or just save your files - Flutter will auto-reload!

## Testing with Backend

If your backend is running locally:
1. Make sure your backend is running on `http://localhost:3000`
2. The `api_service.dart` already defaults to `http://localhost:3000` for local development
3. Run `flutter run -d chrome`
4. Your app will connect to the local backend

## Testing Production Build Locally

To test the exact production build:
```bash
cd flutter
flutter build web --release
cd build/web
python3 -m http.server 8000
```

## Troubleshooting

**Port already in use?**
```bash
flutter run -d chrome --web-port=8081
```

**Want to see verbose output?**
```bash
flutter run -d chrome -v
```

**Clear build cache?**
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

## Tips

- Keep the terminal open while testing - it shows errors and logs
- Use Chrome DevTools (F12) to debug
- Check the Network tab to see API calls
- The app will auto-reload when you save files

