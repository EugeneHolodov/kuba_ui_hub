import 'package:flutter/material.dart';

/// Reusable Material 3 Toggle widget for selecting one of two options
///
/// Features:
/// - Material 3 SegmentedButton base widget
/// - Two option selection
/// - Customizable title/label
/// - Primary and secondary color support
/// - Disabled state support
/// - Optional subtitle/description
/// - Fully reusable and customizable
class KubaToggle<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final T? value;
  final T option1;
  final T option2;
  final String label1;
  final String label2;
  final ValueChanged<T?>? onChanged;
  final Color? accentColor;
  final Color? onAccentColor;
  final bool disabled;
  final MainAxisAlignment titleAlignment;

  const KubaToggle({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.option1,
    required this.option2,
    required this.label1,
    required this.label2,
    this.onChanged,
    this.accentColor,
    this.onAccentColor,
    this.disabled = false,
    this.titleAlignment = MainAxisAlignment.spaceBetween,
  });

  bool get _isEnabled => !disabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveAccentColor = accentColor ?? theme.colorScheme.primary;
    final effectiveOnAccentColor = onAccentColor ?? theme.colorScheme.onPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: titleAlignment,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isEnabled
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _isEnabled
                            ? theme.colorScheme.onSurface.withOpacity(0.7)
                            : theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: effectiveAccentColor.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SegmentedButton<T>(
            segments: [
              ButtonSegment<T>(value: option1, label: Text(label1)),
              ButtonSegment<T>(value: option2, label: Text(label2)),
            ],
            selected: value != null ? {value!} : {},
            emptySelectionAllowed: true,
            onSelectionChanged: _isEnabled
                ? (Set<T> newSelection) {
                    if (newSelection.isEmpty) {
                      onChanged!(null);
                    } else {
                      onChanged!(newSelection.first);
                    }
                  }
                : null,
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: effectiveAccentColor,
              selectedForegroundColor: effectiveOnAccentColor,
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: _isEnabled
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.6),
              side: BorderSide(color: theme.colorScheme.outline, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
