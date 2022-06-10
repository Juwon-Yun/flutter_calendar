import 'package:flutter/material.dart';
import 'package:flutter_calendar/components/calendar.dart';
import 'package:flutter_calendar/components/new_schedule_bottom_sheet.dart';
import 'package:flutter_calendar/components/schedule_card.dart';
import 'package:flutter_calendar/components/today_banner.dart';
import 'package:flutter_calendar/constants/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Calendar(
                  selectedDay: selectedDay,
                  focusedDay: focusedDay,
                  onDaySelected: _onDaySelected,
                ),
                const SizedBox(height: 8),
                TodayBanner(
                  scheduleCount: 1,
                  selectedDay: selectedDay,
                ),
                SizedBox(height: 8),
                _ScheduleList(),
              ],
            ),
          ),
        ),
        floatingActionButton: renderFloatingActionButton(),
    );
  }

  _onDaySelected(selected, focused) {
    setState(() {
      selectedDay = selected;
      focusedDay = selected;
    });
  }

  FloatingActionButton renderFloatingActionButton() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              // 디폴트가 화면의 절반만큼만 사용하는 걸 풀어줌
              isScrollControlled: true,
              builder: (_) {
                return ScheduleBottomSheet();
              });
        },
        backgroundColor: primary_color,
        child: const Icon(Icons.add),
      );
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: 190,
              itemBuilder: (context, index) {
                return ScheduleCard(
                    startTime: 8,
                    endTime: 9,
                    content: '프로그래밍 공부하기 $index',
                    color: Colors.red);
              })),
    );
  }
}
