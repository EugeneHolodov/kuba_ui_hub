import 'package:flutter/material.dart';
import '../widgets/kuba_dialog.dart';
import '../widgets/review_input.dart';

class DialogOverviewPage extends StatelessWidget {
  const DialogOverviewPage({super.key});

  void _showBasicDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Basic Dialog',
      content: 'This is a basic dialog with title and content text.',
      actions: [
        KubaDialogAction(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        KubaDialogAction(
          label: 'OK',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showPrimaryStyleDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Primary Style Dialog',
      content: 'This dialog uses the primary style with brand colors.',
      useSecondaryStyle: false,
      actions: [
        KubaDialogAction(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        KubaDialogAction(
          label: 'Confirm',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showSecondaryStyleDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Secondary Style Dialog',
      content:
          'This dialog uses the secondary style with orange accent colors.',
      useSecondaryStyle: true,
      actions: [
        KubaDialogAction(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        KubaDialogAction(
          label: 'Confirm',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showDialogWithIcon(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Dialog with Icon',
      content:
          'This dialog includes an icon in the header for better visual communication.',
      icon: Icons.info_outline,
      actions: [
        KubaDialogAction(
          label: 'Got it',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showDialogWithCustomIcon(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Custom Icon Color',
      content: 'This dialog uses a custom icon color for the warning icon.',
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
      actions: [
        KubaDialogAction(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        KubaDialogAction(
          label: 'Continue',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Confirm Action',
      content:
          'Are you sure you want to delete this item? This action cannot be undone.',
      icon: Icons.delete_outline,
      iconColor: Theme.of(context).colorScheme.error,
      actions: [
        KubaDialogAction(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        KubaDialogAction(
          label: 'Delete',
          isPrimary: true,
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Item deleted')));
          },
        ),
      ],
    );
  }

  void _showDialogWithCustomContent(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Custom Content Widget',
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This dialog uses a custom widget instead of simple text content.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(child: Text('Feature enabled')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Expanded(child: Text('Settings configured')),
              ],
            ),
          ),
        ],
      ),
      actions: [
        KubaDialogAction(
          label: 'Close',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showSingleActionDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Success',
      content: 'Your changes have been saved successfully!',
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      actions: [
        KubaDialogAction(
          label: 'OK',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showNoActionDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Information',
      content: 'This dialog has no action buttons. Tap outside to dismiss.',
      barrierDismissible: true,
    );
  }

  void _showDialogWithDoNotShowAgain(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Tip',
      content:
          'You can enable "Don\'t show again" to hide this dialog until you leave the current page.',
      icon: Icons.lightbulb_outline,
      showDoNotShowAgain: true,
      onDoNotShowAgainChanged: (value) {
        if (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dialog will be hidden until you leave this page'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      actions: [
        KubaDialogAction(
          label: 'Got it',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showAnimatedDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Smooth Animated Dialog',
      content:
          'All dialogs now feature smooth scale and fade animations by default. The animation uses a Material 3 style curve for a polished feel.',
      icon: Icons.animation,
      animationDuration: const Duration(milliseconds: 300),
      actions: [
        KubaDialogAction(
          label: 'OK',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _showCustomDurationDialog(BuildContext context) {
    KubaDialog.show(
      context: context,
      title: 'Custom Animation Speed',
      content:
          'You can customize the animation duration. This dialog uses a faster animation (150ms).',
      icon: Icons.speed,
      animationDuration: const Duration(milliseconds: 150),
      actions: [
        KubaDialogAction(
          label: 'OK',
          isPrimary: true,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Overview'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dialog Variants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore different dialog styles and use cases:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => _showBasicDialog(context),
                  icon: const Icon(Icons.message),
                  label: const Text('Basic Dialog'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showPrimaryStyleDialog(context),
                  icon: const Icon(Icons.palette),
                  label: const Text('Primary Style'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showSecondaryStyleDialog(context),
                  icon: const Icon(Icons.color_lens),
                  label: const Text('Secondary Style'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showDialogWithIcon(context),
                  icon: const Icon(Icons.info),
                  label: const Text('With Icon'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showDialogWithCustomIcon(context),
                  icon: const Icon(Icons.warning),
                  label: const Text('Custom Icon'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showConfirmationDialog(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Confirmation'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showDialogWithCustomContent(context),
                  icon: const Icon(Icons.widgets),
                  label: const Text('Custom Content'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showSingleActionDialog(context),
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Single Action'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showNoActionDialog(context),
                  icon: const Icon(Icons.info_outline),
                  label: const Text('No Actions'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showDialogWithDoNotShowAgain(context),
                  icon: const Icon(Icons.check_box_outline_blank),
                  label: const Text('Don\'t Show Again'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Animation Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'All dialogs feature smooth scale and fade animations. Customize the duration:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => _showAnimatedDialog(context),
                  icon: const Icon(Icons.animation),
                  label: const Text('Default Animation'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showCustomDurationDialog(context),
                  icon: const Icon(Icons.speed),
                  label: const Text('Fast Animation'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Dialogs',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'KubaDialog provides a consistent Material 3 dialog implementation with brand colors. All dialogs use Material 3 design principles and automatically adapt to your theme.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Features:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Primary and secondary style variants\n'
                      '• Optional icon support with custom colors\n'
                      '• Flexible content (text or custom widgets)\n'
                      '• Configurable action buttons\n'
                      '• "Don\'t show again" option with page-scope\n'
                      '• Smooth scale + fade animations (always enabled)\n'
                      '• Customizable animation duration\n'
                      '• Material 3 design with brand colors\n'
                      '• Barrier dismissible option',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Usage Example:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        '''KubaDialog.show(
  context: context,
  title: 'Confirm Action',
  content: 'Are you sure?',
  actions: [
    KubaDialogAction(
      label: 'Cancel',
      onPressed: () => Navigator.pop(context),
    ),
    KubaDialogAction(
      label: 'Confirm',
      isPrimary: true,
      onPressed: () => Navigator.pop(context),
    ),
  ],
);''',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_dialog',
      ).buildFloatingActionButton(context),
    );
  }
}
