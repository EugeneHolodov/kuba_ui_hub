import 'package:flutter/material.dart';

// Bottom sheet footer with action buttons
class KubaBottomSheetFooter extends StatelessWidget {
  final String actionButtonText;
  final VoidCallback? onAction;
  final bool useSecondaryStyle;

  const KubaBottomSheetFooter({
    super.key,
    required this.actionButtonText,
    this.onAction,
    this.useSecondaryStyle = false,
  });

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              if (onAction != null) {
                onAction!();
              }
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: useSecondaryStyle
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              foregroundColor: useSecondaryStyle
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onPrimary,
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
