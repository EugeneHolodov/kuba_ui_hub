import 'package:flutter/material.dart';
import 'kuba_bottom_sheet_minimal_header.dart';
import 'kuba_bottom_sheet_full_header.dart';
import 'kuba_bottom_sheet_footer.dart';

/// Reusable bottom sheet widget with optional action buttons.
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
/// KubaBottomSheet.show(
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
class KubaBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onClose;
  final bool useSecondaryStyle;
  final bool minimalStyle;
  final String? actionButtonText;
  final VoidCallback? onAction;
  final bool actionButtonEnabled;
  final ValueNotifier<bool>? actionButtonEnabledNotifier;

  const KubaBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.onClose,
    this.useSecondaryStyle = false,
    this.minimalStyle = false,
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
    bool minimalStyle = false,
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
        return KubaBottomSheet(
          title: title,
          subtitle: subtitle,
          onClose: onClose,
          useSecondaryStyle: useSecondaryStyle,
          minimalStyle: minimalStyle,
          actionButtonText: actionButtonText,
          onAction: onAction,
          actionButtonEnabled: actionButtonEnabled,
          actionButtonEnabledNotifier: actionButtonEnabledNotifier,
          child: child,
        );
      },
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
            if (minimalStyle)
              KubaBottomSheetMinimalHeader(
                title: title,
                subtitle: subtitle,
                onClose: onClose,
                useSecondaryStyle: useSecondaryStyle,
              )
            else
              KubaBottomSheetFullHeader(
                title: title,
                subtitle: subtitle,
                onClose: onClose,
                useSecondaryStyle: useSecondaryStyle,
              ),
            // Content
            Flexible(child: child),
            // Footer with action buttons (if actionButtonText is provided)
            if (actionButtonText != null)
              KubaBottomSheetFooter(
                actionButtonText: actionButtonText!,
                onAction: onAction,
                useSecondaryStyle: useSecondaryStyle,
                actionButtonEnabled: actionButtonEnabled,
                actionButtonEnabledNotifier: actionButtonEnabledNotifier,
              ),
          ],
        ),
      ),
    );
  }
}
