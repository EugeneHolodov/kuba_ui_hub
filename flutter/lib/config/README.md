# Kuba UI Hub - Color & Theme Configuration

This directory contains centralized color and theme configuration files for the entire application. This system makes it easy to maintain consistency, switch themes, and implement white-labeling.

## Files Overview

### 📁 `kuba_colors.dart`
Contains all color definitions used throughout the app.

### 📁 `kuba_theme.dart`
Contains theme configurations built using colors from `kuba_colors.dart`.

---

## 🎨 How to Use Colors

### Basic Usage

Instead of using hardcoded colors:

```dart
// ❌ DON'T DO THIS
Container(
  color: Color(0xFF93328E),
  child: Text('Hello', style: TextStyle(color: Colors.black87)),
)
```

Use centralized colors:

```dart
// ✅ DO THIS
import 'package:material3_app/config/kuba_colors.dart';

Container(
  color: KubaColors.primary,
  child: Text('Hello', style: TextStyle(color: KubaColors.onSurface)),
)
```

### Available Color Categories

#### 1. Brand Colors
```dart
KubaColors.primary           // Primary brand color (Purple)
KubaColors.primaryTint       // Lighter purple
KubaColors.secondary         // Secondary brand color (Orange)
KubaColors.secondaryTint     // Lighter orange
```

#### 2. Status Colors
```dart
KubaColors.statusOk          // Success/OK status (Lime green)
KubaColors.statusNA          // Not applicable (Purple-blue)
KubaColors.statusDeviation   // Deviation/Warning (Deep orange)
KubaColors.error             // Error color
KubaColors.success           // General success color
KubaColors.warning           // Warning color
KubaColors.info              // Info color
```

#### 3. Surface Colors
```dart
KubaColors.surface                    // Main background
KubaColors.surfaceContainerHighest    // Container background
KubaColors.surfaceContainerHigh       // Higher container
KubaColors.surfaceVariant             // Surface variant
```

#### 4. Text Colors
```dart
KubaColors.onSurface         // Primary text
KubaColors.onSurfaceVariant  // Secondary text
KubaColors.onPrimary         // Text on primary color
KubaColors.onSecondary       // Text on secondary color
KubaColors.onError           // Text on error color
KubaColors.textDisabled      // Disabled text
KubaColors.textDark          // Dark text for emphasis
```

#### 5. Border & Outline Colors
```dart
KubaColors.outline           // Main borders
KubaColors.outlineVariant    // Lighter borders
KubaColors.divider           // Divider lines
```

#### 6. Chart Colors
```dart
KubaColors.chart1            // Chart color 1 (Primary)
KubaColors.chart2            // Chart color 2 (Secondary)
KubaColors.chart3            // Chart color 3 (Teal)
KubaColors.chart4            // Chart color 4 (Pink)
KubaColors.chart5            // Chart color 5 (Blue)
KubaColors.chart6            // Chart color 6 (Green)
```

#### 7. Gradient Definitions
```dart
KubaColors.primaryGradient   // Purple gradient
KubaColors.secondaryGradient // Orange gradient
KubaColors.successGradient   // Green gradient
```

---

## 🎭 How to Use Themes

### Setup in main.dart

```dart
import 'package:material3_app/config/kuba_theme.dart';

MaterialApp(
  title: 'Kuba UI Hub',
  theme: KubaTheme.lightTheme,        // Light theme
  darkTheme: KubaTheme.darkTheme,     // Dark theme (optional)
  themeMode: ThemeMode.light,         // or ThemeMode.system
  home: HomePage(),
)
```

### Accessing Theme Colors in Widgets

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  
  return Container(
    color: colorScheme.primary,          // From theme
    child: Text(
      'Hello',
      style: theme.textTheme.titleLarge, // From theme
    ),
  );
}
```

### When to Use Theme vs Direct Colors

- **Use Theme colors** (`colorScheme.primary`) when you want automatic theme switching
- **Use Direct colors** (`KubaColors.primary`) when you need a specific color regardless of theme

---

## 🏷️ White-Labeling & Theme Switching

### Option 1: Use Pre-built Alternative Themes

```dart
// In main.dart
MaterialApp(
  theme: KubaTheme.blueTheme,   // Blue theme
  // OR
  theme: KubaTheme.greenTheme,  // Green theme
  // OR
  theme: KubaTheme.redTheme,    // Red theme
  ...
)
```

### Option 2: Runtime Theme Switching

```dart
import 'package:material3_app/config/kuba_theme.dart';
import 'package:provider/provider.dart'; // You need to add provider package

// In main.dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => KubaThemeManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<KubaThemeManager>(
      builder: (context, themeManager, child) {
        return MaterialApp(
          theme: themeManager.currentTheme,
          home: HomePage(),
        );
      },
    );
  }
}

// Switch theme from anywhere in the app
void switchToBlueTheme(BuildContext context) {
  Provider.of<KubaThemeManager>(context, listen: false).setBlueTheme();
}
```

### Option 3: Create Custom Brand Theme

1. **Add your brand colors** to `kuba_colors.dart`:

```dart
/// Custom brand color scheme
class KubaColorsCustomBrand {
  KubaColorsCustomBrand._();
  
  static const Color primary = Color(0xFF123456);
  static const Color primaryTint = Color(0xFF234567);
  static const Color secondary = Color(0xFF345678);
  static const Color secondaryTint = Color(0xFF456789);
}
```

2. **Create custom theme** in `kuba_theme.dart`:

```dart
static ThemeData get customBrandTheme {
  return lightTheme.copyWith(
    colorScheme: lightColorScheme.copyWith(
      primary: KubaColorsCustomBrand.primary,
      primaryContainer: KubaColorsCustomBrand.primaryTint,
      secondary: KubaColorsCustomBrand.secondary,
      secondaryContainer: KubaColorsCustomBrand.secondaryTint,
    ),
  );
}
```

3. **Use in app**:

```dart
MaterialApp(
  theme: KubaTheme.customBrandTheme,
  ...
)
```

---

## 🛠️ Color Utilities

### Convert Hex to Color

```dart
Color myColor = KubaColorUtils.fromHex('#FF5733');
Color myColor2 = KubaColorUtils.fromHex('FF5733');
```

### Convert Color to Hex

```dart
String hexColor = KubaColorUtils.toHex(KubaColors.primary);
// Returns: "#93328e"
```

### Lighten/Darken Colors

```dart
Color lighterPrimary = KubaColorUtils.lighten(KubaColors.primary, 0.2);
Color darkerPrimary = KubaColorUtils.darken(KubaColors.primary, 0.2);
```

### Add Opacity

```dart
Color transparentPrimary = KubaColorUtils.withOpacity(KubaColors.primary, 0.5);
```

---

## 📋 Migration Guide

### Migrating Existing Widgets

1. **Import the colors file**:
```dart
import '../config/kuba_colors.dart';
```

2. **Replace hardcoded colors**:

```dart
// Before
color: Color(0xFF93328E)
color: Colors.lightGreen.shade300
color: Colors.grey.shade100

// After
color: KubaColors.primary
color: KubaColors.statusOk
color: KubaColors.surfaceContainerHighest
```

3. **Test the widget** to ensure colors look correct

### Common Replacements

| Old Color | New Color |
|-----------|-----------|
| `Color(0xFF93328E)` | `KubaColors.primary` |
| `Color(0xFF9E4799)` | `KubaColors.primaryTint` |
| `Color(0xFFF1B434)` | `KubaColors.secondary` |
| `Color(0xFFF2BC48)` | `KubaColors.secondaryTint` |
| `Colors.lightGreen.shade300` | `KubaColors.statusOk` |
| `Colors.indigo.shade200` | `KubaColors.statusNA` |
| `Colors.deepOrange.shade200` | `KubaColors.statusDeviation` |
| `Colors.grey.shade100` | `KubaColors.surfaceContainerHighest` |
| `Colors.grey.shade400` | `KubaColors.outline` |
| `Colors.black87` | `KubaColors.onSurface` |
| `Colors.white` | `KubaColors.surface` or `KubaColors.onPrimary` |
| `Colors.transparent` | `KubaColors.transparent` |

---

## 🎯 Best Practices

1. **Always use centralized colors** - Never hardcode color values
2. **Use semantic names** - Use `statusOk` instead of `lightGreen`
3. **Consistent usage** - Use the same color for the same purpose throughout the app
4. **Theme-aware** - Use `Theme.of(context).colorScheme` when you want theme switching
5. **Document custom colors** - Add comments when adding new color definitions
6. **Test on different themes** - Always test your UI with different theme variations

---

## 📝 Examples

### Example 1: Card with Brand Colors

```dart
import 'package:material3_app/config/kuba_colors.dart';

Card(
  color: KubaColors.surface,
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: KubaColors.outline),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Container(
          color: KubaColors.primary,
          child: Text(
            'Header',
            style: TextStyle(color: KubaColors.onPrimary),
          ),
        ),
        Text(
          'Body text',
          style: TextStyle(color: KubaColors.onSurface),
        ),
      ],
    ),
  ),
)
```

### Example 2: Status Indicator

```dart
import 'package:material3_app/config/kuba_colors.dart';

Widget buildStatusIndicator(ChecklistStatus status) {
  Color statusColor;
  
  switch (status) {
    case ChecklistStatus.ok:
      statusColor = KubaColors.statusOk;
      break;
    case ChecklistStatus.na:
      statusColor = KubaColors.statusNA;
      break;
    case ChecklistStatus.deviation:
      statusColor = KubaColors.statusDeviation;
      break;
  }
  
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: statusColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      status.toString(),
      style: TextStyle(color: KubaColors.onSurface),
    ),
  );
}
```

### Example 3: Chart with Multiple Colors

```dart
import 'package:material3_app/config/kuba_colors.dart';

PieChart(
  dataMap: {
    'Section 1': 30,
    'Section 2': 25,
    'Section 3': 20,
    'Section 4': 15,
    'Section 5': 10,
  },
  colorList: [
    KubaColors.chart1,
    KubaColors.chart2,
    KubaColors.chart3,
    KubaColors.chart4,
    KubaColors.chart5,
  ],
)
```

---

## 🚀 Quick Start Checklist

- [x] Import `kuba_theme.dart` in `main.dart`
- [x] Set theme: `theme: KubaTheme.lightTheme`
- [ ] Import `kuba_colors.dart` in your widgets
- [ ] Replace hardcoded colors with `KubaColors.*`
- [ ] Test your UI with different themes
- [ ] Document any custom colors you add

---

## 📚 Additional Resources

- Flutter Material Design 3: https://m3.material.io/
- Flutter Theme Documentation: https://docs.flutter.dev/cookbook/design/themes
- Color Theory for UI: https://material.io/design/color/

---

## 🤝 Contributing

When adding new colors:

1. Add them to `kuba_colors.dart` with descriptive names
2. Add documentation comments
3. Group them logically (e.g., all status colors together)
4. Update this README with examples
5. Test across all themes

---

**Version:** 1.0.0  
**Last Updated:** December 2025  
**Maintainer:** Kuba UI Hub Team

