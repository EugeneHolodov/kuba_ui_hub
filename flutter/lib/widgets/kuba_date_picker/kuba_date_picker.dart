import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../kuba_bottom_sheet/kuba_bottom_sheet.dart';

class KubaDateRangePicker extends StatelessWidget {
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?> onChanged;
  final String labelText;
  final String hintText;
  final bool isPrimary;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String bottomSheetTitle;
  final bool isRange;

  const KubaDateRangePicker({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = 'Select Date Range',
    this.hintText = 'Tap to pick a date range',
    this.isPrimary = true,
    this.firstDate,
    this.lastDate,
    this.bottomSheetTitle = 'Select Date Range',
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

  void _showBottomSheetDateRangePicker(BuildContext context) {
    DateTime? tempStartDate = value?.start;
    DateTime? tempEndDate = value?.end;
    DateTime displayDate = tempStartDate ?? DateTime.now();

    // Create a ValueNotifier to track button enabled state
    final actionButtonEnabledNotifier = ValueNotifier<bool>(
      isRange
          ? (tempStartDate != null && tempEndDate != null)
          : (tempStartDate != null),
    );

    KubaBottomSheet.show(
      context: context,
      title: bottomSheetTitle,
      actionButtonText: 'Confirm',
      onAction: () {
        if (isRange) {
          // Range mode - both dates required
          if (tempStartDate != null && tempEndDate != null) {
            onChanged(DateTimeRange(start: tempStartDate!, end: tempEndDate!));
          }
        } else {
          // Single date mode
          if (tempStartDate != null) {
            onChanged(
              DateTimeRange(start: tempStartDate!, end: tempStartDate!),
            );
          }
        }
      },
      useSecondaryStyle: !isPrimary,
      actionButtonEnabledNotifier: actionButtonEnabledNotifier,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          // Calculate max height for content (calendar + padding)
          final screenHeight = MediaQuery.of(context).size.height;
          final maxContentHeight = screenHeight * 0.5; // Limit to 50% of screen

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxContentHeight),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    // Calendar with range visualization
                    SizedBox(
                      height: 350,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: _getAccentColor(context),
                          ),
                        ),
                        child: RangeCalendarPicker(
                          startDate: tempStartDate,
                          endDate: tempEndDate,
                          firstDate: firstDate ?? DateTime(2000),
                          lastDate: lastDate ?? DateTime(2100),
                          currentDisplayedMonthDate: displayDate,
                          isRange: isRange,
                          onStartDateChanged: (DateTime? date) {
                            setModalState(() {
                              tempStartDate = date;
                              if (date != null) {
                                displayDate = date;
                              }
                              // Update button enabled state
                              if (isRange) {
                                actionButtonEnabledNotifier.value =
                                    tempStartDate != null &&
                                    tempEndDate != null;
                              } else {
                                actionButtonEnabledNotifier.value =
                                    tempStartDate != null;
                              }
                            });
                          },
                          onEndDateChanged: (DateTime? date) {
                            setModalState(() {
                              tempEndDate = date;
                              // Update button enabled state
                              if (isRange) {
                                actionButtonEnabledNotifier.value =
                                    tempStartDate != null &&
                                    tempEndDate != null;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
              onTap: () => _showBottomSheetDateRangePicker(context),
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

class RangeCalendarPicker extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime currentDisplayedMonthDate;
  final bool isRange;
  final ValueChanged<DateTime?> onStartDateChanged;
  final ValueChanged<DateTime?> onEndDateChanged;

  const RangeCalendarPicker({
    required this.startDate,
    required this.endDate,
    required this.firstDate,
    required this.lastDate,
    required this.currentDisplayedMonthDate,
    this.isRange = true,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  State<RangeCalendarPicker> createState() => _RangeCalendarPickerState();
}

class _RangeCalendarPickerState extends State<RangeCalendarPicker> {
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.currentDisplayedMonthDate.year,
      widget.currentDisplayedMonthDate.month,
    );
  }

  void _handleDateTap(DateTime date) {
    if (widget.isRange) {
      // Range selection logic
      if (widget.startDate == null) {
        // First selection - set as start date
        widget.onStartDateChanged(date);
        widget.onEndDateChanged(null);
      } else if (widget.endDate == null) {
        // Second selection - set as end date
        if (date.isBefore(widget.startDate!)) {
          // If selected date is before start, swap them
          widget.onEndDateChanged(widget.startDate);
          widget.onStartDateChanged(date);
        } else {
          widget.onEndDateChanged(date);
        }
      } else {
        // Reset and start new selection
        widget.onStartDateChanged(date);
        widget.onEndDateChanged(null);
      }
    } else {
      // Single date selection - just set the date
      widget.onStartDateChanged(date);
      widget.onEndDateChanged(null);
    }
  }

  bool _isInRange(DateTime date) {
    if (!widget.isRange)
      return false; // No range highlighting in single date mode
    if (widget.startDate == null || widget.endDate == null) return false;
    final start = DateTime(
      widget.startDate!.year,
      widget.startDate!.month,
      widget.startDate!.day,
    );
    final end = DateTime(
      widget.endDate!.year,
      widget.endDate!.month,
      widget.endDate!.day,
    );
    final current = DateTime(date.year, date.month, date.day);
    return current.isAfter(start) && current.isBefore(end);
  }

  bool _isStartDate(DateTime date) {
    if (widget.startDate == null) return false;
    return date.year == widget.startDate!.year &&
        date.month == widget.startDate!.month &&
        date.day == widget.startDate!.day;
  }

  bool _isEndDate(DateTime date) {
    if (widget.endDate == null) return false;
    return date.year == widget.endDate!.year &&
        date.month == widget.endDate!.month &&
        date.day == widget.endDate!.day;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    // Get the last day of the month by going to day 0 of next month
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth =
        lastDay.day; // This gives us the number of days in the month

    // weekday: Monday = 1, Sunday = 7
    // Convert to Sunday = 0, Monday = 1, ..., Saturday = 6
    int firstWeekday = firstDay.weekday;
    if (firstWeekday == 7) {
      firstWeekday = 0; // Sunday becomes 0
    }

    final days = <DateTime>[];

    // Add previous month days to fill the first week
    // If first day is Sunday (0), no previous days needed
    // If first day is Monday (1), need 1 previous day, etc.
    if (firstWeekday > 0) {
      for (int i = firstWeekday - 1; i >= 0; i--) {
        days.add(firstDay.subtract(Duration(days: i + 1)));
      }
    }

    // Add all days of the current month (1 to daysInMonth)
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(DateTime(month.year, month.month, day));
    }

    // Add next month days to fill the remaining weeks (always 6 weeks = 42 days)
    final totalDays = days.length;
    final remainingDays = 42 - totalDays;
    if (remainingDays > 0) {
      for (int i = 1; i <= remainingDays; i++) {
        days.add(lastDay.add(Duration(days: i)));
      }
    }

    return days;
  }

  void _previousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  void _showYearPicker() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 24,
          ),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              width: 300,
              height: 420,
              color: Theme.of(context).colorScheme.surface,
              child: ClipRect(
                child: OverflowBox(
                  minHeight: 436,
                  maxHeight: 436,
                  child: Material(
                    color: Colors.transparent,
                    child: YearPicker(
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      selectedDate: _displayedMonth,
                      onChanged: (DateTime date) {
                        setState(() {
                          _displayedMonth = DateTime(
                            date.year,
                            _displayedMonth.month,
                          );
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final days = _getDaysInMonth(_displayedMonth);
    final weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      children: [
        // Header with month/year and navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              TextButton(
                onPressed: _showYearPicker,
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(_displayedMonth),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
                tooltip: 'Previous month',
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
                tooltip: 'Next month',
              ),
            ],
          ),
        ),
        // Week day headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: weekDays.map((day) {
              return Expanded(
                child: Center(
                  child: ExcludeSemantics(
                    child: Text(
                      day,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        // Calendar grid with range visualization
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: days.length,
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final date = days[index];
                // Check if date belongs to the displayed month
                final isCurrentMonth =
                    date.year == _displayedMonth.year &&
                    date.month == _displayedMonth.month;

                // Show empty cell for non-current month dates to maintain grid alignment
                if (!isCurrentMonth) {
                  return Container(); // Empty container maintains grid structure
                }

                final isStart = _isStartDate(date);
                final isEnd = _isEndDate(date);
                final isInRange = _isInRange(date);
                final isToday = _isToday(date);
                final isDisabled =
                    date.isBefore(widget.firstDate) ||
                    date.isAfter(widget.lastDate);

                return _buildDayCell(
                  context,
                  date,
                  isCurrentMonth: isCurrentMonth,
                  isStart: isStart,
                  isEnd: isEnd,
                  isInRange: isInRange,
                  isToday: isToday,
                  isDisabled: isDisabled,
                  colorScheme: colorScheme,
                  textTheme: theme.textTheme,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    DateTime date, {
    required bool isCurrentMonth,
    required bool isStart,
    required bool isEnd,
    required bool isInRange,
    required bool isToday,
    required bool isDisabled,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    final isSelected = isStart || isEnd;

    Color? backgroundColor;
    Color? textColor;
    FontWeight? fontWeight;

    if (isDisabled) {
      textColor = colorScheme.onSurface.withOpacity(0.38);
    } else if (isSelected) {
      backgroundColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
      fontWeight = FontWeight.w600;
    } else if (isInRange) {
      backgroundColor = colorScheme.primary.withOpacity(0.12);
      textColor = colorScheme.onSurface;
    } else {
      textColor = colorScheme.onSurface;
    }

    return InkResponse(
      onTap: isDisabled ? null : () => _handleDateTap(date),
      radius: 20,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(color: colorScheme.primary, width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
