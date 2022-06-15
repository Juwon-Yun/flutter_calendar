import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;

  const Calendar(
      {Key? key,
      required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.w600,
    );

    return TableCalendar(
      locale: 'ko_KR',
      selectedDayPredicate: (date) {
        if (selectedDay == null) {
          return date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
        leftChevronIcon : Icon(Icons.chevron_left_outlined, color: primary_color),
        rightChevronIcon: Icon(Icons.chevron_right_outlined, color: primary_color),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultDeco,
        holidayDecoration: defaultDeco,
        weekendDecoration: defaultDeco,
        selectedDecoration: defaultDeco.copyWith(
          color: Colors.white,
          border: Border.all(width: 1.0, color: primary_color),
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: primary_color,
        ),
        outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
      ),
      onDaySelected: onDaySelected,
    );
  }
}
