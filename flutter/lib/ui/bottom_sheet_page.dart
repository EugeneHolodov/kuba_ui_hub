import 'package:flutter/material.dart';
import '../widgets/kuba_bottom_sheet/kuba_bottom_sheet.dart';
import '../widgets/kuba_bottom_sheet/kuba_bottom_sheet_minimal.dart';
import '../widgets/review_input.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  // State for multiple selection examples
  List<String> _regularSelectedValues = [];
  List<String> _minimalSelectedValues = [];

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

  void _showRegularMultipleSelection(BuildContext context) {
    // Local variable to hold temporary selections
    List<String> selectedValues = List<String>.from(_regularSelectedValues);

    KubaBottomSheet.show(
      context: context,
      title: 'Multiple Selection',
      subtitle: 'Select multiple options with checkboxes',
      actionButtonText: 'Confirm',
      onAction: () {
        // Update parent state with selected values (closure captures selectedValues)
        setState(() {
          _regularSelectedValues = selectedValues;
        });
      },
      child: StatefulBuilder(
        builder: (context, setModalState) {
          final screenHeight = MediaQuery.of(context).size.height;
          final maxListHeight = screenHeight * 0.6;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxListHeight),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final option = _options[index];
                  final isSelected = selectedValues.contains(option);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(option),
                        subtitle: Text('Description for $option'),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (bool? checked) {
                              setModalState(() {
                                if (checked == true) {
                                  selectedValues.add(option);
                                } else {
                                  selectedValues.remove(option);
                                }
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              selectedValues.remove(option);
                            } else {
                              selectedValues.add(option);
                            }
                          });
                        },
                      ),
                      if (index < _options.length - 1)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showMinimalMultipleSelection(BuildContext context) {
    // Local variable to hold temporary selections
    List<String> selectedValues = List<String>.from(_minimalSelectedValues);

    KubaBottomSheetMinimal.show(
      context: context,
      title: 'Multiple Selection',
      subtitle: 'Select multiple options with checkboxes (Minimal Style)',
      actionButtonText: 'Confirm',
      onAction: () {
        // Update parent state with selected values (closure captures selectedValues)
        setState(() {
          _minimalSelectedValues = selectedValues;
        });
      },
      child: StatefulBuilder(
        builder: (context, setModalState) {
          final screenHeight = MediaQuery.of(context).size.height;
          final maxListHeight = screenHeight * 0.6;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxListHeight),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final option = _options[index];
                  final isSelected = selectedValues.contains(option);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(option),
                        subtitle: Text('Description for $option'),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (bool? checked) {
                              setModalState(() {
                                if (checked == true) {
                                  selectedValues.add(option);
                                } else {
                                  selectedValues.remove(option);
                                }
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              selectedValues.remove(option);
                            } else {
                              selectedValues.add(option);
                            }
                          });
                        },
                      ),
                      if (index < _options.length - 1)
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    ],
                  );
                },
              ),
            ),
          );
        },
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
            const SizedBox(height: 8),
            const Text(
              'Choose a style to see the bottom sheet in action:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
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
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Multiple Selection Examples',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Examples showing how to implement multiple selection with action buttons:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => _showRegularMultipleSelection(context),
                  icon: const Icon(Icons.check_box),
                  label: const Text('Regular (Multiple)'),
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
                  onPressed: () => _showMinimalMultipleSelection(context),
                  icon: const Icon(Icons.check_box_outline_blank),
                  label: const Text('Minimal (Multiple)'),
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
            // Show selected values if any
            if (_regularSelectedValues.isNotEmpty ||
                _minimalSelectedValues.isNotEmpty) ...[
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Values',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_regularSelectedValues.isNotEmpty) ...[
                        Text(
                          'Regular: ${_regularSelectedValues.join(", ")}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (_minimalSelectedValues.isNotEmpty) ...[
                        Text(
                          'Minimal: ${_minimalSelectedValues.join(", ")}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
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
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Multiple Selection Pattern:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Create a local variable to hold temporary selections\n'
                      '2. Use StatefulBuilder in the child to manage UI state\n'
                      '3. Pass onAction callback that captures the local variable\n'
                      '4. In onAction, update parent state with selected values\n'
                      '5. The bottom sheet automatically closes after onAction',
                      style: TextStyle(fontSize: 13),
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
