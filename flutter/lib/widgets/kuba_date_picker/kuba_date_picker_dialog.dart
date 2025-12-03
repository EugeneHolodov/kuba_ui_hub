import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KubaDateRangePickerDialog extends StatelessWidget {
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?> onChanged;
  final String labelText;
  final String hintText;
  final bool isPrimary;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String dialogTitle;
  final bool isRange;

  const KubaDateRangePickerDialog({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Select Date Range',
    this.hintText = 'Tap to pick a date range',
    this.isPrimary = true,
    this.firstDate,
    this.lastDate,
    this.dialogTitle = 'Select Date Range',
    this.isRange = true,
  });

  Color _getAccentColor(BuildContext context) {
    return isPrimary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
  }

  Color _getOnAccentColor(BuildContext context) {
    return isPrimary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;
  }

  Future<void> _showDialogDateRangePicker(BuildContext context) async {
    if (isRange) {
      // Range picker mode
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        initialDateRange: value,
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
        helpText: dialogTitle,
        cancelText: 'Cancel',
        confirmText: 'Confirm',
        builder: (BuildContext context, Widget? child) {
          final baseColorScheme = Theme.of(context).colorScheme;
          final accentColor = _getAccentColor(context);
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: baseColorScheme.copyWith(
                primary: accentColor,
                // For range fill, always use accentColor so it matches the picker style
                secondary: accentColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null && picked != value) {
        onChanged(picked);
      }
    } else {
      // Single date picker mode
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: value?.start ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(2100),
        helpText: dialogTitle,
        cancelText: 'Cancel',
        confirmText: 'Confirm',
        builder: (BuildContext context, Widget? child) {
          final accentColor = _getAccentColor(context);
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: accentColor),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        // Convert single date to DateTimeRange with same start and end
        onChanged(DateTimeRange(start: picked, end: picked));
      }
    }
  }

  bool _hasValue() {
    return value != null;
  }

  String _getDisplayText() {
    if (value == null) return '';
    if (!isRange) {
      // Single date mode - just show the start date
      return DateFormat('yyyy-MM-dd').format(value!.start);
    }
    final start = DateFormat('yyyy-MM-dd').format(value!.start);
    final end = DateFormat('yyyy-MM-dd').format(value!.end);
    if (start == end) {
      return start;
    }
    return '$start → $end';
  }

  Widget _buildStatusIcon(BuildContext context, bool hasValue) {
    if (hasValue) {
      final accentColor = _getAccentColor(context);
      final onAccentColor = _getOnAccentColor(context);
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.check, size: 18, color: onAccentColor),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = _hasValue();
    final showStatusIcon = hasValue;
    final accentColor = _getAccentColor(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: _getDisplayText()),
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.black87),
                hintText: hintText,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                prefixIcon: Icon(Icons.date_range, color: accentColor),
                suffixIcon: _hasValue()
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
                    color: hasValue
                        ? accentColor
                        : Theme.of(context).colorScheme.outline,
                    width: hasValue ? 2 : 1,
                  ),
                ),
              ),
              onTap: () => _showDialogDateRangePicker(context),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child: showStatusIcon
              ? Row(
                  children: [
                    const SizedBox(width: 8),
                    _buildStatusIcon(context, hasValue),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
