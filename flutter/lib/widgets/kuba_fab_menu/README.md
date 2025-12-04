# Kuba FAB Menu Widget

A Material 3 compliant Floating Action Button Menu implementation for Flutter.

## Overview

The `KubaFabMenu` widget provides an expandable FAB menu that follows Material 3 design guidelines. It includes smooth animations, an optional scrim overlay, and customizable menu items.

## Features

- ✅ Material 3 design compliance
- ✅ Smooth expand/collapse animations
- ✅ Optional scrim (overlay) when expanded
- ✅ Extended FAB-style menu items (pill buttons)
- ✅ Customizable colors
- ✅ Support for labels and tooltips
- ✅ Flexible menu item configuration
- ✅ Hero animation support
- ✅ Fully reusable component

## Basic Usage

```dart
import 'package:your_app/widgets/kuba_fab_menu.dart';

// In your widget build method
floatingActionButton: KubaFabMenu(
  mainIcon: Icons.add,
  tooltip: 'Create new',
  showScrim: true,
  menuItems: [
    FabMenuItem(
      icon: Icons.image,
      label: 'Image',
      tooltip: 'Add image',
      heroTag: 'fab_image',
      onPressed: () {
        // Handle image action
      },
    ),
    FabMenuItem(
      icon: Icons.video_library,
      label: 'Video',
      tooltip: 'Add video',
      heroTag: 'fab_video',
      onPressed: () {
        // Handle video action
      },
    ),
  ],
)
```

## Properties

### KubaFabMenu

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `mainIcon` | IconData | Icons.add | The main icon shown when the menu is closed |
| `openIcon` | IconData? | null | The icon shown when the menu is open (defaults to Icons.close) |
| `menuItems` | List<FabMenuItem> | required | List of menu items to display |
| `backgroundColor` | Color? | null | Background color of the main FAB (defaults to primaryContainer) |
| `foregroundColor` | Color? | null | Foreground color of the main FAB (defaults to onPrimaryContainer) |
| `showScrim` | bool | true | Whether to show a scrim (overlay) when menu is expanded |
| `tooltip` | String? | null | Tooltip for the main FAB |
| `onMenuStateChanged` | ValueChanged<bool>? | null | Callback when menu state changes |

### FabMenuItem

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | IconData | required | The icon to display |
| `label` | String | required | Label text |
| `onPressed` | VoidCallback | required | Callback when the item is pressed |
| `backgroundColor` | Color? | null | Optional background color (defaults to secondaryContainer) |
| `foregroundColor` | Color? | null | Optional foreground color (defaults to onSecondaryContainer) |
| `tooltip` | String? | null | Optional tooltip |
| `heroTag` | Object? | null | Optional hero tag (must be unique) |

## Advanced Usage

### Custom Colors

```dart
KubaFabMenu(
  mainIcon: Icons.add,
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  menuItems: [
    FabMenuItem(
      icon: Icons.image,
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      onPressed: () {},
    ),
  ],
)
```

### Without Scrim

```dart
KubaFabMenu(
  mainIcon: Icons.add,
  showScrim: false,
  menuItems: [...],
)
```

### With State Callback

```dart
KubaFabMenu(
  mainIcon: Icons.add,
  onMenuStateChanged: (isOpen) {
    print('Menu is ${isOpen ? 'open' : 'closed'}');
  },
  menuItems: [...],
)
```

## Design Notes

This widget follows the Material 3 FAB menu design specifications:

1. **Animation**: Uses a 250ms duration with easeInOut curve for smooth transitions
2. **Rotation**: The main FAB icon rotates 45 degrees (1/8 turn) when opening
3. **Spacing**: 16dp spacing between menu items
4. **Extended FABs**: Menu items use extended FAB style (pill buttons with icon + label)
5. **Elevation**: Main FAB has 6dp elevation when closed, 0dp when open; menu items have 2dp elevation
6. **Colors**: Uses Material 3 color scheme tokens (primaryContainer, secondaryContainer, etc.)
7. **Layout**: Menu items are displayed vertically above the close button

## Tips

1. **Hero Tags**: Always provide unique `heroTag` values for each menu item to avoid hero animation conflicts
2. **Labels**: Keep labels short and descriptive (1-2 words)
3. **Icons**: Use clear, recognizable icons from the Material Icons library
4. **Actions**: Keep menu items to 3-5 items for best UX
5. **Scrim**: The scrim helps focus attention on the menu and provides a tap target to close
6. **Order**: Menu items appear in the order you provide them (top to bottom)

## Example Implementation

See `lib/ui/fab_menu_page.dart` for a complete working example with both the reusable widget and a custom implementation.

