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
      appBar: AppBar(
        title: const Text('Date Picker Variants Comparison'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dialog Picker Block
            _buildSectionTitle('Date Picker (Dialog)'),
            const SizedBox(height: 12),
            _buildDialogPickerBlock(),
            const SizedBox(height: 32),

            // Bottom Sheet Picker Block
            _buildSectionTitle('Date Picker (Bottom Sheet)'),
            const SizedBox(height: 12),
            _buildBottomSheetPickerBlock(),
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
        _buildDividerWithTag('Primary - Range'),
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
        _buildDividerWithTag('Primary - Single Date'),
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
        _buildDividerWithTag('Secondary - Range'),
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
        _buildDividerWithTag('Secondary - Single Date'),
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
        _buildDividerWithTag('Primary - Range'),
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
        _buildDividerWithTag('Primary - Single Date'),
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
        _buildDividerWithTag('Secondary - Range'),
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
        _buildDividerWithTag('Secondary - Single Date'),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildDividerWithTag(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(child: Divider(thickness: 1, color: Colors.grey[300])),
        ],
      ),
    );
  }
}
