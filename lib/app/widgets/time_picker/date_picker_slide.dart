import 'package:cooking_project/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class DatePickerSlide extends StatefulWidget {
  final Function(DateTime selectedDate)? onDateSelected;
  final DateTime? initialDate;

  const DatePickerSlide({
    super.key,
    this.onDateSelected,
    this.initialDate,
  });

  @override
  State<DatePickerSlide> createState() => _DatePickerSlideState();
}

class _DatePickerSlideState extends State<DatePickerSlide> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WeeklyDatePicker(
      selectedDay: widget.initialDate ?? DateTime.now(),
      changeDay: (value) => {
        widget.onDateSelected!(value)
      },

      enableWeeknumberText: true,
      weekdayText: 'Thang',
      weeknumberTextColor: colorBlack,
      backgroundColor: colorWhite,
      weekdayTextColor: colorBlack,
      digitsColor: colorBlack,

      selectedDigitBackgroundColor: const Color(0xFF57AF87),
      weekdays: const ["Mo", "Tu", "We", "Th", "Fr","Sa","Su"],
      daysInWeek: 7,
    );
  }
}
