import 'package:flutter/material.dart';
import '../widgets/kuba_date_picker.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime? _dialogDate;
  DateTime? _bottomSheetDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Picker'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker (Dialog)
            KubaDatePicker(
              value: _dialogDate,
              onChanged: (DateTime? date) {
                setState(() {
                  _dialogDate = date;
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
