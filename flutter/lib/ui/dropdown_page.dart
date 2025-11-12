import 'package:flutter/material.dart';
import '../widgets/kuba_dropdown.dart';
import '../widgets/review_input.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String? _bottomSheetValue;
  String? _bottomSheetValue2;
  List<String> _multipleValues = [];
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
            // Bottom Sheet Dropdown (Secondary Style)
            KubaDropdown(
              value: _bottomSheetValue,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _bottomSheetValue = value;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              title: 'Bottom Sheet Dropdown (Secondary)',
            ),
            const SizedBox(height: 32),

            // Bottom Sheet Dropdown (Primary Style)
            KubaDropdown(
              value: _bottomSheetValue2,
              options: _options,
              onChanged: (String? value) {
                setState(() {
                  _bottomSheetValue2 = value;
                });
              },
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              title: 'Bottom Sheet Dropdown (Primary)',
            ),
            const SizedBox(height: 32),

            // Bottom Sheet Dropdown (Multiple Selection)
            KubaDropdown(
              multiple: true,
              values: _multipleValues,
              options: _options,
              onMultipleChanged: (List<String> values) {
                setState(() {
                  _multipleValues = values;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              title: 'Bottom Sheet Dropdown (Multiple)',
              labelText: 'Select Multiple Options',
              bottomSheetTitle: 'Select Options',
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
