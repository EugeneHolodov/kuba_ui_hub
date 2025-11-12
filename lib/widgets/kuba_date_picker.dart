import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'kuba_bottom_sheet.dart';

class KubaDatePicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String labelText;
  final String hintText;
  final Color accentColor;
  final Color onAccentColor;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool useBottomSheet;
  final String bottomSheetTitle;

  const KubaDatePicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Select Date',
    this.hintText = 'Tap to pick a date',
    required this.accentColor,
    required this.onAccentColor,
    this.firstDate,
    this.lastDate,
    this.useBottomSheet = false,
    this.bottomSheetTitle = 'Select Date',
  });

  Future<void> _selectDate(BuildContext context) async {
    // Use DatePickerDialog directly for Material 3
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: value ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100),
          helpText: bottomSheetTitle,
          cancelText: 'Cancel',
          confirmText: 'Confirm',
          // Material 3 styling is automatically applied via theme
        );
      },
    );
    if (picked != null && picked != value) {
      onChanged(picked);
    }
  }

  void _showBottomSheetDatePicker(BuildContext context) {
    DateTime? tempSelectedDate = value ?? DateTime.now();

    KubaBottomSheet.show(
      context: context,
      title: bottomSheetTitle,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        // Date Picker
                        SizedBox(
                          height: 300,
                          child: CalendarDatePicker(
                            initialDate: tempSelectedDate,
                            firstDate: firstDate ?? DateTime(2000),
                            lastDate: lastDate ?? DateTime(2100),
                            onDateChanged: (DateTime date) {
                              setModalState(() {
                                tempSelectedDate = date;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              // Buttons with accent color (fixed at bottom)
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
                      onPressed: () {
                        onChanged(tempSelectedDate);
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: onAccentColor,
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
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              useBottomSheet
                  ? 'Date Picker (Bottom Sheet)'
                  : 'Date Picker (Dialog)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (value != null)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, size: 16, color: onAccentColor),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(useBottomSheet ? 0.15 : 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            readOnly: true,
            controller: TextEditingController(
              text: value != null
                  ? DateFormat('yyyy-MM-dd').format(value!)
                  : '',
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.black87),
              hintText: hintText,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              prefixIcon: useBottomSheet
                  ? Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    )
                  : Icon(Icons.calendar_today, color: accentColor),
              suffixIcon: value != null
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.grey[600],
                      onPressed: () {
                        onChanged(null);
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: value != null
                      ? accentColor
                      : Theme.of(context).colorScheme.outline,
                  width: value != null ? 2 : 1,
                ),
              ),
            ),
            onTap: () {
              if (useBottomSheet) {
                _showBottomSheetDatePicker(context);
              } else {
                _selectDate(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
