import 'package:flutter/material.dart';
import '../widgets/kuba_bottom_sheet/kuba_bottom_sheet.dart';
import '../widgets/kuba_bottom_sheet/kuba_bottom_sheet_minimal.dart';
import '../widgets/review_input.dart';

class BottomSheetPage extends StatelessWidget {
  const BottomSheetPage({super.key});

  void _showRegularBottomSheet(BuildContext context) {
    KubaBottomSheet.show(
      context: context,
      title: 'Regular Header Style',
      subtitle:
          'This bottom sheet uses the regular header with gradient background',
      actionButtonText: 'Confirm',
      onAction: () {
        // Action handler
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Content Area',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 8,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('Option ${index + 1}'),
                  subtitle: Text('Description for option ${index + 1}'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showMinimalBottomSheet(BuildContext context) {
    KubaBottomSheetMinimal.show(
      context: context,
      title: 'Minimal Style',
      subtitle: 'This bottom sheet uses minimal style with simple divider',
      actionButtonText: 'Confirm',
      onAction: () {
        // Action handler
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Content Area',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 8,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('Option ${index + 1}'),
                  subtitle: Text('Description for option ${index + 1}'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Bottom Sheet'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bottom Sheet Variants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Choose a style to see the bottom sheet in action:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => _showRegularBottomSheet(context),
                  icon: const Icon(Icons.gradient),
                  label: const Text('Regular Header'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showMinimalBottomSheet(context),
                  icon: const Icon(Icons.minimize),
                  label: const Text('Minimal Style'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
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
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Bottom Sheets',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Regular Header: Features a gradient background with primary/secondary colors and a prominent header design.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Minimal Style: Simple design with a divider line and clean header without gradient background.',
                      style: TextStyle(fontSize: 14),
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
        widgetName: 'kuba_bottom_sheet',
      ).buildFloatingActionButton(context),
    );
  }
}
