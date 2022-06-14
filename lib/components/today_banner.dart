import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants/colors.dart';
import 'package:flutter_calendar/model/schedule_with_color.dart';
import 'package:flutter_calendar/repository/init_db.dart';
import 'package:get_it/get_it.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;

  const TodayBanner(
      {Key? key, required this.selectedDay})
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
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                int count = 0;

                if(snapshot.hasData){
                  count = snapshot.data!.length;
                }

                if (count == 0) {
                  return const SizedBox(height: 8);
                }

                return Text(
                  '$count개',
                  style: textStyle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
