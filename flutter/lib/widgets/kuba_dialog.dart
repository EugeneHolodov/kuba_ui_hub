import 'package:flutter/material.dart';

/// Reusable Material 3 dialog widget with brand colors.
///
/// This widget provides a consistent dialog style across the app using
/// Material 3 design principles and brand colors.
///
/// **Basic Usage:**
/// ```dart
/// KubaDialog.show(
///   context: context,
///   title: 'Confirm Action',
///   content: 'Are you sure you want to proceed?',
///   actions: [
///     KubaDialogAction(
///       label: 'Cancel',
///       onPressed: () => Navigator.pop(context),
///     ),
///     KubaDialogAction(
///       label: 'Confirm',
///       isPrimary: true,
///       onPressed: () {
///         // Handle confirmation
///         Navigator.pop(context);
///       },
///     ),
///   ],
/// );
/// ```
///
/// **With Custom Content Widget:**
/// ```dart
/// KubaDialog.show(
///   context: context,
///   title: 'Custom Dialog',
///   contentWidget: Column(
///     children: [
///       Text('Custom content here'),
///       // ... more widgets
///     ],
///   ),
///   actions: [
///     KubaDialogAction(
///       label: 'OK',
///       isPrimary: true,
///       onPressed: () => Navigator.pop(context),
///     ),
///   ],
/// );
/// ```
class KubaDialog extends StatefulWidget {
  final String title;
  final String? content;
  final Widget? contentWidget;
  final List<KubaDialogAction>? actions;
  final bool useSecondaryStyle;
  final IconData? icon;
  final Color? iconColor;
  final bool showDoNotShowAgain;
  final ValueChanged<bool>? onDoNotShowAgainChanged;

  const KubaDialog({
    super.key,
    required this.title,
    this.content,
    this.contentWidget,
    this.actions,
    this.useSecondaryStyle = false,
    this.icon,
    this.iconColor,
    this.showDoNotShowAgain = false,
    this.onDoNotShowAgainChanged,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? content,
    Widget? contentWidget,
    List<KubaDialogAction>? actions,
    bool useSecondaryStyle = false,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    bool showDoNotShowAgain = false,
    ValueChanged<bool>? onDoNotShowAgainChanged,
    Duration animationDuration = const Duration(milliseconds: 250),
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: animationDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return KubaDialog(
          title: title,
          content: content,
          contentWidget: contentWidget,
          actions: actions,
          useSecondaryStyle: useSecondaryStyle,
          icon: icon,
          iconColor: iconColor,
          showDoNotShowAgain: showDoNotShowAgain,
          onDoNotShowAgainChanged: onDoNotShowAgainChanged,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Smooth Material 3 style animation: scale + fade
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.85,
              end: 1.0,
            ).animate(curvedAnimation),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<KubaDialog> createState() => _KubaDialogState();
}

class _KubaDialogState extends State<KubaDialog> {
  bool _doNotShowAgain = false;

  @override
  Widget build(BuildContext context) {
    return _KubaDialogContent(
      title: widget.title,
      content: widget.content,
      contentWidget: widget.contentWidget,
      actions: widget.actions,
      useSecondaryStyle: widget.useSecondaryStyle,
      icon: widget.icon,
      iconColor: widget.iconColor,
      showDoNotShowAgain: widget.showDoNotShowAgain,
      doNotShowAgain: _doNotShowAgain,
      onDoNotShowAgainChanged: (value) {
        setState(() {
          _doNotShowAgain = value;
        });
        widget.onDoNotShowAgainChanged?.call(value);
      },
    );
  }
}

class _KubaDialogContent extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? contentWidget;
  final List<KubaDialogAction>? actions;
  final bool useSecondaryStyle;
  final IconData? icon;
  final Color? iconColor;
  final bool showDoNotShowAgain;
  final bool doNotShowAgain;
  final ValueChanged<bool>? onDoNotShowAgainChanged;

  const _KubaDialogContent({
    required this.title,
    this.content,
    this.contentWidget,
    this.actions,
    this.useSecondaryStyle = false,
    this.icon,
    this.iconColor,
    this.showDoNotShowAgain = false,
    this.doNotShowAgain = false,
    this.onDoNotShowAgainChanged,
  });

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        content != null || contentWidget != null ? 16 : 24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    iconColor ??
                    (useSecondaryStyle
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.primaryContainer),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color:
                    iconColor ??
                    (useSecondaryStyle
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onPrimaryContainer),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (contentWidget != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: contentWidget!,
      );
    }

    if (content != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          content!,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDoNotShowAgain(BuildContext context) {
    if (!showDoNotShowAgain) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton.icon(
            onPressed: () {
              onDoNotShowAgainChanged?.call(!doNotShowAgain);
            },
            icon: Icon(
              doNotShowAgain ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
            ),
            label: const Text('Don\'t show again'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Applies until you leave this page',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (actions == null || actions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          final isLast = index == actions!.length - 1;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionButton(context, action),
              if (!isLast) const SizedBox(width: 12),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, KubaDialogAction action) {
    if (action.isPrimary) {
      return FilledButton(
        onPressed: action.onPressed,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(action.label),
      );
    } else {
      return OutlinedButton(
        onPressed: action.onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(action.label),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          if (content != null || contentWidget != null) ...[
            Flexible(
              child: SingleChildScrollView(child: _buildContent(context)),
            ),
          ],
          _buildDoNotShowAgain(context),
          if (content != null || contentWidget != null)
            const SizedBox(height: 8),
          _buildActions(context),
        ],
      ),
    );
  }
}

/// Action button configuration for KubaDialog.
///
/// Each action represents a button in the dialog footer.
class KubaDialogAction {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const KubaDialogAction({
    required this.label,
    this.onPressed,
    this.isPrimary = false,
  });
}
