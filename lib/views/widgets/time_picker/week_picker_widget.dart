import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WeekPicker extends StatefulWidget {
  final Function(DateTime startOfWeek, DateTime endOfWeek)? onWeekSelected;
  final DateTime? initialDate;

  const WeekPicker({
    Key? key,
    this.onWeekSelected,
    this.initialDate,
  }) : super(key: key);

  @override
  State<WeekPicker> createState() => _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  late DateTime _selectedDate;
  late DateTime _startOfWeek;
  late DateTime _endOfWeek;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    _calculateWeekBoundaries();
  }

  void _calculateWeekBoundaries() {
    // Find the first day of the week (Monday)
    _startOfWeek = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    // Find the last day of the week (Sunday)
    _endOfWeek = _startOfWeek.add(const Duration(days: 6));

    if (widget.onWeekSelected != null) {
      widget.onWeekSelected!(_startOfWeek, _endOfWeek);
    }
  }

  void _selectPreviousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
      _calculateWeekBoundaries();
    });
  }

  void _selectNextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 7));
      _calculateWeekBoundaries();
    });
  }

  void _showWeekPickerDialog() async {
    final result = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return _WeekPickerDialog(
          initialDate: _selectedDate,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedDate = result;
        _calculateWeekBoundaries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final String weekRange = '${dateFormat.format(_startOfWeek)} - ${dateFormat.format(_endOfWeek)}';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon:  Icon(Icons.chevron_left, size: 12.sp,),
              onPressed: _selectPreviousWeek,
            ),
            GestureDetector(
              onTap: _showWeekPickerDialog,
              child: Row(
                children: [
                   Icon(Icons.calendar_today, size: 12.sp),
                  const SizedBox(width: 8),
                  Text(
                    weekRange,
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon:  Icon(Icons.chevron_right,size: 12.sp),
              onPressed: _selectNextWeek,
            ),
          ],
        ),
      );
  }
}

class _WeekPickerDialog extends StatefulWidget {
  final DateTime initialDate;

  const _WeekPickerDialog({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  @override
  _WeekPickerDialogState createState() => _WeekPickerDialogState();
}

class _WeekPickerDialogState extends State<_WeekPickerDialog> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  late List<DateTime> _weeks;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    _calculateWeeks();
  }

  void _calculateWeeks() {
    _weeks = [];


    final DateTime firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);

    DateTime weekStart = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday - 1));


    if (firstDayOfMonth.weekday == 1) {
      weekStart = firstDayOfMonth;
    } else if (weekStart.month != firstDayOfMonth.month) {

      weekStart = weekStart.add(const Duration(days: 7));
    }

    // Get the last day of the month
    final DateTime lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    // Add weeks until we reach the next month
    while (weekStart.month == _currentMonth.month ||
        (weekStart.isBefore(lastDayOfMonth) && weekStart.add(const Duration(days: 6)).month == _currentMonth.month)) {
      _weeks.add(weekStart);
      weekStart = weekStart.add(const Duration(days: 7));
    }
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
      _calculateWeeks();
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
      _calculateWeeks();
    });
  }

  String _getWeekRangeText(DateTime startOfWeek) {
    final DateFormat format = DateFormat('dd/MM/yyyy');
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return '${format.format(startOfWeek)} - ${format.format(endOfWeek)}';
  }

  bool _isSelectedWeek(DateTime weekStart) {
    final DateTime selectedWeekStart =
    _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    return weekStart.year == selectedWeekStart.year &&
        weekStart.month == selectedWeekStart.month &&
        weekStart.day == selectedWeekStart.day;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_currentMonth),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _nextMonth,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            ...List.generate(_weeks.length, (index) {
              final weekStart = _weeks[index];
              final isSelected = _isSelectedWeek(weekStart);

              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(weekStart);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? colorPrimary.withOpacity(0.1) : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      if (isSelected)
                        Icon(Icons.check, color: colorPrimary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getWeekRangeText(weekStart),
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? colorPrimary : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(_selectedDate);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}