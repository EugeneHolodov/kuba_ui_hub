import 'package:flutter/material.dart';

/// Reusable Material 3 Switch widget with title and brand styling
///
/// Features:
/// - Material 3 Switch base widget
/// - Customizable title/label
/// - Primary and secondary color support
/// - Disabled state support
/// - Optional subtitle/description
/// - Fully reusable and customizable
class KubaSwitch extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? accentColor;
  final bool disabled;
  final MainAxisAlignment titleAlignment;

  const KubaSwitch({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.accentColor,
    this.disabled = false,
    this.titleAlignment = MainAxisAlignment.spaceBetween,
  });

  bool get _isEnabled => !disabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveAccentColor =
        accentColor ?? theme.colorScheme.primary;

    return InkWell(
      onTap: _isEnabled ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: titleAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const SizedBox(width: 16),
            Theme(
              data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  primary: effectiveAccentColor,
                ),
              ),
              child: Switch(
                value: value,
                onChanged: _isEnabled ? onChanged : null,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

