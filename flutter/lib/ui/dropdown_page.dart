import 'package:flutter/material.dart';
import '../widgets/kuba_dropdown.dart';
import '../widgets/kuba_dropdown_variant3.dart';
import '../widgets/review_input.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String? _variant1SecondaryValue;
  String? _variant1PrimaryValue;
  List<String> _variant1SecondaryMultiple = [];
  List<String> _variant1PrimaryMultiple = [];

  String? _variant3SecondaryValue;
  String? _variant3PrimaryValue;
  List<String> _variant3SecondaryMultiple = [];
  List<String> _variant3PrimaryMultiple = [];

  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Dropdown'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dropdown Variant 1',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Standard dropdown with checkboxes for selection. Labeled with text.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Variant 1 - KubaDropdown (Secondary Single)
            KubaDropdown(
              value: _variant1SecondaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant1SecondaryValue = value;
                });
              },
              isPrimary: false,
              title: 'Dropdown 1 (Single)',
              labelText: 'Dropdown 1 (Single)',
              bottomSheetTitle: 'Dropdown 1 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 1 - KubaDropdown (Primary Single)
            KubaDropdown(
              value: _variant1PrimaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant1PrimaryValue = value;
                });
              },
              isPrimary: true,
              title: 'Dropdown 1 (Single)',
              labelText: 'Dropdown 1 (Single)',
              bottomSheetTitle: 'Dropdown 1 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 1 - KubaDropdown (Secondary Multiple)
            KubaDropdown(
              multiple: true,
              values: _variant1SecondaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant1SecondaryMultiple = values;
                });
              },
              isPrimary: false,
              title: 'Dropdown 1 (Multiple)',
              labelText: 'Dropdown 1 (Multiple)',
              bottomSheetTitle: 'Dropdown 1 (Multiple)',
            ),
            const SizedBox(height: 32),

            // Variant 1 - KubaDropdown (Primary Multiple)
            KubaDropdown(
              multiple: true,
              values: _variant1PrimaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant1PrimaryMultiple = values;
                });
              },
              isPrimary: true,
              title: 'Dropdown 1 (Multiple)',
              labelText: 'Dropdown 1 (Multiple)',
              bottomSheetTitle: 'Dropdown 1 (Multiple)',
            ),
            const SizedBox(height: 32),
            const Divider(height: 48),
            const SizedBox(height: 16),
            const Text(
              'Dropdown Variant 2',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Card-style dropdown with visual selection indicators. Isn\'t labeled.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Variant 3 - KubaDropdownVariant3 (Secondary Single)
            KubaDropdownVariant3(
              value: _variant3SecondaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant3SecondaryValue = value;
                });
              },
              isPrimary: false,
              bottomSheetTitle: 'Bottom Sheet 2 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 3 - KubaDropdownVariant3 (Primary Single)
            KubaDropdownVariant3(
              value: _variant3PrimaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant3PrimaryValue = value;
                });
              },
              isPrimary: true,
              bottomSheetTitle: 'Dropdown 2 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 3 - KubaDropdownVariant3 (Secondary Multiple)
            KubaDropdownVariant3(
              multiple: true,
              values: _variant3SecondaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant3SecondaryMultiple = values;
                });
              },
              isPrimary: false,
              labelText: 'Dropdown 2 (Multiple)',
              bottomSheetTitle: 'Dropdown 2 (Multiple)',
            ),
            const SizedBox(height: 32),

            // Variant 3 - KubaDropdownVariant3 (Primary Multiple)
            KubaDropdownVariant3(
              multiple: true,
              values: _variant3PrimaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant3PrimaryMultiple = values;
                });
              },
              isPrimary: true,
              labelText: 'Dropdown 2 (Multiple)',
              bottomSheetTitle: 'Dropdown 2 (Multiple)',
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
                          'About Dropdown Variants',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Variant 1: Standard dropdown with checkboxes for selection. Opens a bottom sheet with a list of options. Supports both single and multiple selection modes.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Variant 2: Card-style dropdown with visual selection indicators. Isn\'t labeled. Opens a bottom sheet with a list of options. Supports both single and multiple selection modes.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Color Styles:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Primary: Uses primary color scheme for buttons and highlights\n'
                      '• Secondary: Uses secondary color scheme for a different visual style',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Selection Modes:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Single: Select one option at a time\n'
                      '• Multiple: Select multiple options with checkboxes',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            // Add bottom padding to prevent content from being hidden behind floating button
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_dropdown',
      ).buildFloatingActionButton(context),
    );
  }
}
