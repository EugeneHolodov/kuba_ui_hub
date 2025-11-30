import 'package:flutter/material.dart';
import '../widgets/kuba_dropdown.dart';
import '../widgets/kuba_dropdown_variant2.dart';
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

  String? _variant2SecondaryValue;
  String? _variant2PrimaryValue;
  List<String> _variant2SecondaryMultiple = [];
  List<String> _variant2PrimaryMultiple = [];

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
            // Variant 1 - KubaDropdown (Secondary Single)
            KubaDropdown(
              value: _variant1SecondaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant1SecondaryValue = value;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
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
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
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
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
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
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              title: 'Dropdown 1 (Multiple)',
              labelText: 'Dropdown 1 (Multiple)',
              bottomSheetTitle: 'Dropdown 1 (Multiple)',
            ),
            const SizedBox(height: 32),
            const Divider(height: 48),
            const SizedBox(height: 16),

            // Variant 2 - KubaDropdownVariant2 (Secondary Single)
            KubaDropdownVariant2(
              value: _variant2SecondaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant2SecondaryValue = value;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              bottomSheetTitle: 'Dropdown 2 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 2 - KubaDropdownVariant2 (Primary Single)
            KubaDropdownVariant2(
              value: _variant2PrimaryValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _variant2PrimaryValue = value;
                });
              },
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              bottomSheetTitle: 'Dropdown 2 (Single)',
            ),
            const SizedBox(height: 32),

            // Variant 2 - KubaDropdownVariant2 (Secondary Multiple)
            KubaDropdownVariant2(
              multiple: true,
              values: _variant2SecondaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant2SecondaryMultiple = values;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              labelText: 'Dropdown 2 (Multiple)',
              bottomSheetTitle: 'Dropdown 2 (Multiple)',
            ),
            const SizedBox(height: 32),

            // Variant 2 - KubaDropdownVariant2 (Primary Multiple)
            KubaDropdownVariant2(
              multiple: true,
              values: _variant2PrimaryMultiple,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _variant2PrimaryMultiple = values;
                });
              },
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              labelText: 'Dropdown 2 (Multiple)',
              bottomSheetTitle: 'Dropdown 2 (Multiple)',
            ),
            const SizedBox(height: 32),
            const Divider(height: 48),
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
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              bottomSheetTitle: 'Bottom Sheet 3 (Single)',
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
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              bottomSheetTitle: 'Dropdown 3 (Single)',
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
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              labelText: 'Dropdown 3 (Multiple)',
              bottomSheetTitle: 'Dropdown 3 (Multiple)',
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
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              labelText: 'Dropdown 3 (Multiple)',
              bottomSheetTitle: 'Dropdown 3 (Multiple)',
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
