import 'package:flutter/material.dart';
import '../config/kuba_colors.dart';

/// Theme Switcher Widget
/// 
/// Demonstrates how to switch between different color themes.
/// Useful for white-labeling or testing different brand colors.
/// 
/// Usage:
/// ```dart
/// KubaThemeSwitcher(
///   onThemeChanged: (theme) {
///     // Update app theme
///   },
/// )
/// ```
class KubaThemeSwitcher extends StatelessWidget {
  final ValueChanged<String>? onThemeChanged;

  const KubaThemeSwitcher({
    super.key,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Theme Switcher',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: KubaColors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a theme to preview different color schemes',
              style: theme.textTheme.bodySmall?.copyWith(
                color: KubaColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            _buildThemeOption(
              context,
              'Default (Purple)',
              KubaColors.primary,
              KubaColors.secondary,
              'default',
            ),
            const SizedBox(height: 8),
            _buildThemeOption(
              context,
              'Blue Theme',
              KubaColorsBlue.primary,
              KubaColorsBlue.secondary,
              'blue',
            ),
            const SizedBox(height: 8),
            _buildThemeOption(
              context,
              'Green Theme',
              KubaColorsGreen.primary,
              KubaColorsGreen.secondary,
              'green',
            ),
            const SizedBox(height: 8),
            _buildThemeOption(
              context,
              'Red Theme',
              KubaColorsRed.primary,
              KubaColorsRed.secondary,
              'red',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String name,
    Color primaryColor,
    Color secondaryColor,
    String themeKey,
  ) {
    return InkWell(
      onTap: () => onThemeChanged?.call(themeKey),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: KubaColors.outline),
        ),
        child: Row(
          children: [
            // Color preview circles
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
            const SizedBox(width: 16),
            // Theme name
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: KubaColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Color Palette Display Widget
/// 
/// Displays all available colors in the color system.
/// Useful for documentation and design reference.
class KubaColorPalette extends StatelessWidget {
  const KubaColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          context,
          'Brand Colors',
          [
            _ColorItem('Primary', KubaColors.primary),
            _ColorItem('Primary Tint', KubaColors.primaryTint),
            _ColorItem('Secondary', KubaColors.secondary),
            _ColorItem('Secondary Tint', KubaColors.secondaryTint),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          'Status Colors',
          [
            _ColorItem('Status OK', KubaColors.statusOk),
            _ColorItem('Status N/A', KubaColors.statusNA),
            _ColorItem('Status Deviation', KubaColors.statusDeviation),
            _ColorItem('Error', KubaColors.error),
            _ColorItem('Success', KubaColors.success),
            _ColorItem('Warning', KubaColors.warning),
            _ColorItem('Info', KubaColors.info),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          'Chart Colors',
          [
            _ColorItem('Chart 1', KubaColors.chart1),
            _ColorItem('Chart 2', KubaColors.chart2),
            _ColorItem('Chart 3', KubaColors.chart3),
            _ColorItem('Chart 4', KubaColors.chart4),
            _ColorItem('Chart 5', KubaColors.chart5),
            _ColorItem('Chart 6', KubaColors.chart6),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          context,
          'Surface Colors',
          [
            _ColorItem('Surface', KubaColors.surface),
            _ColorItem('Surface Container Highest', KubaColors.surfaceContainerHighest),
            _ColorItem('Surface Container High', KubaColors.surfaceContainerHigh),
            _ColorItem('Surface Variant', KubaColors.surfaceVariant),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_ColorItem> colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...colors.map((colorItem) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildColorTile(context, colorItem),
        )),
      ],
    );
  }

  Widget _buildColorTile(BuildContext context, _ColorItem colorItem) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KubaColors.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: colorItem.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  colorItem.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _colorToHex(colorItem.color),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KubaColors.onSurfaceVariant,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }
}

class _ColorItem {
  final String name;
  final Color color;

  _ColorItem(this.name, this.color);
}

