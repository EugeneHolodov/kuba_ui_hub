import 'package:flutter/material.dart';
import 'widgets/kuba_date_picker.dart';

/// Custom test page showcasing Material 3 UI components:
/// - DropdownMenu (Material 3)
/// - CalendarDatePicker (Material 3)
/// - DatePickerDialog (Material 3)
/// - FilledButton, OutlinedButton (Material 3)
/// - TextField with Material 3 styling
/// All components use Material 3 design system with custom brand colors
class TestPageCustom extends StatefulWidget {
  const TestPageCustom({super.key});

  @override
  State<TestPageCustom> createState() => _TestPageCustomState();
}

class _TestPageCustomState extends State<TestPageCustom> {
  DateTime? _selectedDate;
  DateTime? _bottomSheetDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Test Page'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Datepicker
            Text(
              'Datepicker',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Divider(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            // Date Picker (Dialog)
            KubaDatePicker(
              value: _selectedDate,
              onChanged: (DateTime? date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              accentColor: Theme.of(context).colorScheme.primary,
              onAccentColor: Theme.of(context).colorScheme.onPrimary,
              useBottomSheet: false,
            ),
            const SizedBox(height: 32),

            // Date Picker (Bottom Sheet)
            KubaDatePicker(
              value: _bottomSheetDate,
              onChanged: (DateTime? date) {
                setState(() {
                  _bottomSheetDate = date;
                });
              },
              accentColor: Theme.of(context).colorScheme.secondary,
              onAccentColor: Theme.of(context).colorScheme.onSecondary,
              useBottomSheet: true,
            ),
          ],
        ),
      ),
    );
  }
}
