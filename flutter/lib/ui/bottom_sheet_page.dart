import 'package:flutter/material.dart';
import '../widgets/kuba_bottom_sheet/kuba_bottom_sheet.dart';
import '../widgets/review_input.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  // Bottom sheet variant states
  String? _bsVariant1Value;
  List<String> _bsVariant1Multiple = [];
  String? _bsVariant2Value;
  List<String> _bsVariant2Multiple = [];
  String? _bsVariant3Value;
  List<String> _bsVariant3Multiple = [];

  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  // Bottom Sheet Variant 1: Checkboxes with bigger padding
  //
  // Pattern for handling actions in parent components:
  // 1. Create a local variable to hold temporary selections (e.g., selectedValues)
  // 2. Use StatefulBuilder in the child to manage UI state
  // 3. Pass onAction callback that captures the local variable (closure)
  // 4. In onAction, update parent state with the selected values
  // The bottom sheet will automatically close after onAction is called
  void _showBottomSheetVariant1(BuildContext context, bool multiple) {
    if (multiple) {
      // Local variable to hold temporary selections
      List<String> selectedValues = List<String>.from(_bsVariant1Multiple);
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 1 (Multiple)',
        actionButtonText: 'Confirm',
        onAction: () {
          // Update parent state with selected values (closure captures selectedValues)
          setState(() {
            _bsVariant1Multiple = selectedValues;
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
                              activeColor: Theme.of(
                                context,
                              ).colorScheme.primary,
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
    } else {
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 1 (Single)',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _options.length,
            itemBuilder: (context, index) {
              final option = _options[index];
              final isSelected = _bsVariant1Value == option;
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
                          if (checked == true) {
                            setState(() {
                              _bsVariant1Value = option;
                            });
                          } else {
                            setState(() {
                              _bsVariant1Value = null;
                            });
                          }
                          Navigator.pop(context);
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _bsVariant1Value = isSelected ? null : option;
                      });
                      Navigator.pop(context);
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
    }
  }

  // Bottom Sheet Variant 2: Switches instead of checkboxes
  void _showBottomSheetVariant2(BuildContext context, bool multiple) {
    if (multiple) {
      // Local variable to hold temporary selections
      List<String> selectedValues = List<String>.from(_bsVariant2Multiple);
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 2 (Multiple)',
        actionButtonText: 'Confirm',
        onAction: () {
          // Update parent state with selected values
          setState(() {
            _bsVariant2Multiple = selectedValues;
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
                        SwitchListTile(
                          value: isSelected,
                          onChanged: (bool value) {
                            setModalState(() {
                              if (value) {
                                selectedValues.add(option);
                              } else {
                                selectedValues.remove(option);
                              }
                            });
                          },
                          title: Text(option),
                          subtitle: Text('Description for $option'),
                          activeColor: Theme.of(context).colorScheme.primary,
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
    } else {
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 2 (Single)',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _options.length,
            itemBuilder: (context, index) {
              final option = _options[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(option),
                    subtitle: Text('Description for $option'),
                    trailing: Radio<String>(
                      value: option,
                      groupValue: _bsVariant2Value,
                      onChanged: (String? value) {
                        setState(() {
                          _bsVariant2Value = value;
                        });
                        Navigator.pop(context);
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () {
                      setState(() {
                        _bsVariant2Value = option;
                      });
                      Navigator.pop(context);
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
    }
  }

  // Bottom Sheet Minimal Style Variants Demo
  void _showBottomSheetMinimalVariant(
    BuildContext context,
    bool useSecondaryStyle,
  ) {
    List<String> selectedValues = [];
    KubaBottomSheet.show(
      context: context,
      title: useSecondaryStyle ? 'Minimal (Secondary)' : 'Minimal (Primary)',
      subtitle: useSecondaryStyle
          ? 'This bottom sheet uses minimal style with secondary colored line and black text.'
          : 'This bottom sheet uses minimal style with primary colored line.',
      useSecondaryStyle: useSecondaryStyle,
      minimalStyle: true,
      child: StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final isSelected = selectedValues.contains(option);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(option),
                        subtitle: Text('Description for $option'),
                        trailing: Checkbox(
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
                          activeColor: useSecondaryStyle
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
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
                }),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
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
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Bottom Sheet Color Variants Demo
  void _showBottomSheetColorVariant(
    BuildContext context,
    bool useSecondaryStyle,
  ) {
    List<String> selectedValues = [];
    KubaBottomSheet.show(
      context: context,
      title: useSecondaryStyle ? 'Select Options' : 'Select Option',
      subtitle: useSecondaryStyle
          ? 'Select one or more options'
          : 'Select one option',
      useSecondaryStyle: useSecondaryStyle,
      child: StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final isSelected = selectedValues.contains(option);
                  return Column(
                    children: [
                      ListTile(
                        title: Text(option),
                        subtitle: Text('Description for $option'),
                        trailing: Checkbox(
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
                          activeColor: useSecondaryStyle
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
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
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  // Bottom Sheet Variant 3: Card style with check icon
  void _showBottomSheetVariant3(BuildContext context, bool multiple) {
    if (multiple) {
      // Local variable to hold temporary selections
      List<String> selectedValues = List<String>.from(_bsVariant3Multiple);
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 3 (Multiple)',
        actionButtonText: 'Confirm',
        onAction: () {
          // Update parent state with selected values
          setState(() {
            _bsVariant3Multiple = selectedValues;
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
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      elevation: isSelected ? 4 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              selectedValues.remove(option);
                            } else {
                              selectedValues.add(option);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Description for $option',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 28,
                                )
                              else
                                Icon(
                                  Icons.radio_button_unchecked,
                                  color: Colors.grey[400],
                                  size: 28,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    } else {
      KubaBottomSheet.show(
        context: context,
        title: 'Bottom Sheet 3 (Single)',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _options.length,
            itemBuilder: (context, index) {
              final option = _options[index];
              final isSelected = _bsVariant3Value == option;
              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                elevation: isSelected ? 4 : 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _bsVariant3Value = isSelected ? null : option;
                    });
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Description for $option',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          )
                        else
                          Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey[400],
                            size: 28,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
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
            // Bottom Sheet Variants Section
            const Text(
              'Bottom Sheet Variants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Variant 1 - Checkboxes with bigger padding
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => _showBottomSheetVariant1(context, false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Text('Variant 1 (Single)'),
                ),
                FilledButton(
                  onPressed: () => _showBottomSheetVariant1(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Text('Variant 1 (Multiple)'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Variant 2 - Switches
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => _showBottomSheetVariant2(context, false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Variant 2 (Single)'),
                ),
                FilledButton(
                  onPressed: () => _showBottomSheetVariant2(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Variant 2 (Multiple)'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Variant 3 - Card style
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => _showBottomSheetVariant3(context, false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Variant 3 (Single)'),
                ),
                FilledButton(
                  onPressed: () => _showBottomSheetVariant3(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Variant 3 (Multiple)'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(height: 48),
            const SizedBox(height: 16),

            // Bottom Sheet Color Variants Section
            const Text(
              'Bottom Sheet Color Variants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Color Variants
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => _showBottomSheetColorVariant(context, false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Primary Style'),
                ),
                FilledButton(
                  onPressed: () => _showBottomSheetColorVariant(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Text('Secondary Style'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(height: 48),
            const SizedBox(height: 16),

            // Bottom Sheet Minimal Style Variants Section
            const Text(
              'Bottom Sheet Minimal Style',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Minimal Style Variants
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () =>
                      _showBottomSheetMinimalVariant(context, false),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Minimal (Primary)'),
                ),
                FilledButton(
                  onPressed: () =>
                      _showBottomSheetMinimalVariant(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: const Text('Minimal (Secondary)'),
                ),
              ],
            ),
            // Add bottom padding to prevent content from being hidden behind floating button
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
