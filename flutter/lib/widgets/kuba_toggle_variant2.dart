import 'package:flutter/material.dart';

/// Reusable Material 3 Toggle widget variant 2 for long text labels
///
/// Features:
/// - Material 3 SegmentedButton base widget
/// - Two option selection with multiline text support
/// - Customizable title/label
/// - Primary and secondary color support
/// - Disabled state support
/// - Optional subtitle/description
/// - Better handling of long text labels
/// - Fully reusable and customizable
class KubaToggleVariant2<T> extends StatelessWidget {
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
  final String? errorText;

  const KubaToggleVariant2({
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
    this.errorText,
  });

  bool get _isEnabled => !disabled && onChanged != null;

  bool _hasValue() {
    return value != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveAccentColor = accentColor ?? theme.colorScheme.primary;
    final effectiveOnAccentColor = onAccentColor ?? theme.colorScheme.onPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              height: 24,
              child: errorText != null
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.priority_high,
                        size: 16,
                        color: Colors.white,
                      ),
                    )
                  : _hasValue()
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: effectiveAccentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 16,
                        color: effectiveOnAccentColor,
                      ),
                    )
                  : null,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<T>(
                        segments: [
                          ButtonSegment<T>(
                            value: option1,
                            label: Container(
                              constraints: const BoxConstraints(
                                minHeight: 44,
                                minWidth: double.infinity,
                              ),
                              child: Center(
                                child: Text(
                                  label1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          ButtonSegment<T>(
                            value: option2,
                            label: Container(
                              constraints: const BoxConstraints(
                                minHeight: 44,
                                minWidth: double.infinity,
                              ),
                              child: Center(
                                child: Text(
                                  label2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
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
                        multiSelectionEnabled: false,
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: effectiveAccentColor,
                          selectedForegroundColor: effectiveOnAccentColor,
                          backgroundColor: theme.colorScheme.surface,
                          foregroundColor: _isEnabled
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurface.withOpacity(0.6),
                          side: BorderSide(
                            color: theme.colorScheme.outline,
                            width: 1,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    // Reserved space for validation message - seamless with toggle
                    Container(
                      height: 20,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 4,
                      ),
                      decoration: BoxDecoration(
                        color: errorText != null
                            ? theme.colorScheme.error.withOpacity(0.02)
                            : theme.colorScheme.surface.withOpacity(0.02),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorText ?? ' ',
                        style: TextStyle(
                          color: errorText != null
                              ? theme.colorScheme.error
                              : Colors.transparent,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
