import 'package:flutter/material.dart';
import '../widgets/kuba_date_picker/kuba_date_picker.dart';
import '../widgets/kuba_date_picker/kuba_date_picker_dialog.dart';
import '../widgets/review_input.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  // Dialog Picker states
  DateTimeRange? _dialogPrimaryRange;
  DateTimeRange? _dialogPrimarySingle;
  DateTimeRange? _dialogSecondaryRange;
  DateTimeRange? _dialogSecondarySingle;

  // Bottom Sheet Picker states
  DateTimeRange? _bottomSheetPrimaryRange;
  DateTimeRange? _bottomSheetPrimarySingle;
  DateTimeRange? _bottomSheetSecondaryRange;
  DateTimeRange? _bottomSheetSecondarySingle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Date Picker'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Picker (Dialog)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Opens a dialog-style date picker. Supports both single date and date range selection.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildDialogPickerBlock(),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Date Picker (Bottom Sheet)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Opens a bottom sheet-style date picker. Provides a more mobile-friendly selection experience.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildBottomSheetPickerBlock(),
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
                          'About Date Pickers',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dialog Picker: Opens a centered dialog with a calendar interface. Best for desktop and tablet experiences. Supports both single date and date range selection modes.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bottom Sheet Picker: Opens a bottom sheet with a calendar interface. More mobile-friendly and follows Material Design guidelines. Also supports single date and date range selection.',
                      style: TextStyle(fontSize: 14),
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
                      '• Single Date: Select a single date from the calendar\n'
                      '• Date Range: Select a start and end date to create a range',
                      style: TextStyle(fontSize: 13),
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
        widgetName: 'kuba_date_picker',
      ).buildFloatingActionButton(context),
    );
  }

  Widget _buildDialogPickerBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KubaDateRangePickerDialog(
          value: _dialogPrimaryRange,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _dialogPrimaryRange = range;
            });
          },
          isPrimary: true,
          isRange: true,
        ),
        const SizedBox(height: 24),

        KubaDateRangePickerDialog(
          value: _dialogPrimarySingle,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _dialogPrimarySingle = range;
            });
          },
          isPrimary: true,
          isRange: false,
        ),
        const SizedBox(height: 24),
        KubaDateRangePickerDialog(
          value: _dialogSecondaryRange,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _dialogSecondaryRange = range;
            });
          },
          isPrimary: false,
          isRange: true,
        ),
        const SizedBox(height: 24),
        KubaDateRangePickerDialog(
          value: _dialogSecondarySingle,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _dialogSecondarySingle = range;
            });
          },
          isPrimary: false,
          isRange: false,
        ),
      ],
    );
  }

  Widget _buildBottomSheetPickerBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KubaDateRangePicker(
          value: _bottomSheetPrimaryRange,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _bottomSheetPrimaryRange = range;
            });
          },
          isPrimary: true,
          isRange: true,
        ),
        const SizedBox(height: 24),

        KubaDateRangePicker(
          value: _bottomSheetPrimarySingle,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _bottomSheetPrimarySingle = range;
            });
          },
          isPrimary: true,
          isRange: false,
        ),
        const SizedBox(height: 24),

        KubaDateRangePicker(
          value: _bottomSheetSecondaryRange,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _bottomSheetSecondaryRange = range;
            });
          },
          isPrimary: false,
          isRange: true,
        ),
        const SizedBox(height: 24),

        KubaDateRangePicker(
          value: _bottomSheetSecondarySingle,
          onChanged: (DateTimeRange? range) {
            setState(() {
              _bottomSheetSecondarySingle = range;
            });
          },
          isPrimary: false,
          isRange: false,
        ),
      ],
    );
  }
}
