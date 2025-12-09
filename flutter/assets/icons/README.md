# Icons Assets Folder

This folder contains custom icon assets for the Kuba UI Hub application.

## Usage

Place your icon files (SVG, PNG, etc.) in this directory and reference them in your code:

```dart
Image.asset('assets/icons/your_icon.png')
```

## Supported Formats

- PNG (recommended for raster icons)
- SVG (recommended for vector icons - requires `flutter_svg` package)
- JPG/JPEG (for photos, not recommended for icons)

## Best Practices

- Use PNG for simple icons with transparency
- Use SVG for scalable vector icons
- Name files descriptively (e.g., `norway_flag.png`, `menu_icon.svg`)
- Use lowercase with underscores for file names
- Consider creating different sizes (@1x, @2x, @3x) for better quality on different screen densities

