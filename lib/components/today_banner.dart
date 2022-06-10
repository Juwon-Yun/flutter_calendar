import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;

  const TodayBanner(
      {Key? key, required this.selectedDay, required this.scheduleCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Colors.white,
    );

    return Container(
      color: primary_color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: textStyle,
            ),
            Text(
              '$scheduleCount개',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
