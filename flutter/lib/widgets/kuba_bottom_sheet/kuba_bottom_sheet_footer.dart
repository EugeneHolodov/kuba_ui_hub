import 'package:flutter/material.dart';

// Bottom sheet footer with action buttons
class KubaBottomSheetFooter extends StatelessWidget {
  final String actionButtonText;
  final VoidCallback? onAction;
  final bool useSecondaryStyle;
  final bool actionButtonEnabled;
  final ValueNotifier<bool>? actionButtonEnabledNotifier;

  const KubaBottomSheetFooter({
    super.key,
    required this.actionButtonText,
    this.onAction,
    this.useSecondaryStyle = false,
    this.actionButtonEnabled = true,
    this.actionButtonEnabledNotifier,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: Text(actionButtonText),
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
            child: Text(actionButtonText),
          ),
        ],
      ),
    );
  }
}
