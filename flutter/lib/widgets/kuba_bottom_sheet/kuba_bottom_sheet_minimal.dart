import 'package:flutter/material.dart';

/// Reusable bottom sheet widget with minimal header style (simple divider).
///
/// **Action Button Pattern:**
/// When using action buttons with state management:
/// 1. Create a local variable to hold temporary selections (e.g., `List<String> selectedValues`)
/// 2. Use `StatefulBuilder` in the `child` to manage UI state within the bottom sheet
/// 3. Pass `actionButtonText` and `onAction` callback that captures the local variable (closure)
/// 4. In `onAction`, update parent state with the selected values
/// 5. The bottom sheet will automatically close after `onAction` is called
///
/// Example:
/// ```dart
/// List<String> selectedValues = [];
/// KubaBottomSheetMinimal.show(
///   context: context,
///   title: 'Select Items',
///   actionButtonText: 'Confirm',
///   onAction: () {
///     setState(() {
///       _parentState = selectedValues;
///     });
///   },
///   child: StatefulBuilder(
///     builder: (context, setModalState) {
///       // Your content that modifies selectedValues
///     },
///   ),
/// );
/// ```
class KubaBottomSheetMinimal extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onClose;
  final bool useSecondaryStyle;
  final String? actionButtonText;
  final VoidCallback? onAction;
  final bool actionButtonEnabled;
  final ValueNotifier<bool>? actionButtonEnabledNotifier;

  const KubaBottomSheetMinimal({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.onClose,
    this.useSecondaryStyle = false,
    this.actionButtonText,
    this.onAction,
    this.actionButtonEnabled = true,
    this.actionButtonEnabledNotifier,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    required Widget child,
    VoidCallback? onClose,
    bool useSecondaryStyle = false,
    String? actionButtonText,
    VoidCallback? onAction,
    bool actionButtonEnabled = true,
    ValueNotifier<bool>? actionButtonEnabledNotifier,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true, // Allow bottom sheet to resize with keyboard
      // Material 3 bottom sheet styling
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return KubaBottomSheetMinimal(
          title: title,
          subtitle: subtitle,
          onClose: onClose,
          useSecondaryStyle: useSecondaryStyle,
          actionButtonText: actionButtonText,
          onAction: onAction,
          actionButtonEnabled: actionButtonEnabled,
          actionButtonEnabledNotifier: actionButtonEnabledNotifier,
          child: child,
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Handle bar (small line)
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: useSecondaryStyle
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: useSecondaryStyle
                            ? Colors.black
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: useSecondaryStyle
                            ? FontWeight.w500
                            : FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: useSecondaryStyle
                              ? Colors.black87
                              : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: useSecondaryStyle
                      ? Colors.black
                      : Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  if (onClose != null) {
                    onClose!();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
        // Divider between header and content
        Container(height: 1, color: Theme.of(context).colorScheme.outline),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    // If we have a notifier, use ValueListenableBuilder for reactive updates
    if (actionButtonEnabledNotifier != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ValueListenableBuilder<bool>(
              valueListenable: actionButtonEnabledNotifier!,
              builder: (context, enabled, child) {
                return FilledButton(
                  onPressed: enabled && onAction != null
                      ? () {
                          onAction!();
                          Navigator.pop(context);
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: useSecondaryStyle
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    foregroundColor: useSecondaryStyle
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.onPrimary,
                    disabledBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    disabledForegroundColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(actionButtonText!),
                );
              },
            ),
          ],
        ),
      );
    }

    // Otherwise use static enabled state
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: actionButtonEnabled && onAction != null
                ? () {
                    onAction!();
                    Navigator.pop(context);
                  }
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: useSecondaryStyle
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              foregroundColor: useSecondaryStyle
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onPrimary,
              disabledBackgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              disabledForegroundColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: Text(actionButtonText!),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get keyboard height to adjust bottom sheet position
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            // Content
            Flexible(child: child),
            // Footer with action buttons (if actionButtonText is provided)
            if (actionButtonText != null) _buildFooter(context),
          ],
        ),
      ),
    );
  }
}
