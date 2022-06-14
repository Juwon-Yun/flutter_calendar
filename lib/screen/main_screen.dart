import 'package:flutter/material.dart';
import 'package:flutter_calendar/components/calendar.dart';
import 'package:flutter_calendar/components/new_schedule_bottom_sheet.dart';
import 'package:flutter_calendar/components/schedule_card.dart';
import 'package:flutter_calendar/components/today_banner.dart';
import 'package:flutter_calendar/constants/colors.dart';
import 'package:flutter_calendar/repository/init_db.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 문제는 처음에 앱을 시작했을때 UTC 기준이 아닌 한국 시간 기준으로 했기 때문에 버그가 있다.
  // schedule 을 insert 할때도 한국 시간 기준으로 넣기 때문에 UTC 기준으로 select하지 못한다.
  // 결론 => select, insert 전부 현지 기준으로할지 utc기준으로 할지 하나만 선택해 데이터를 관리한다.
  // DateTime selectedDay = DateTime(
  DateTime selectedDay = DateTime.utc(
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
              _ScheduleList(selectedDay: selectedDay),
            ],
          ),
        ),
      ),
      floatingActionButton: renderFloatingActionButton(),
    );
  }

  // UTC 기준으로 날짜 DateTime을 붙여주기 때문에 Z를 붙여준다.
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
                return ScheduleBottomSheet(
                  selectedDate: selectedDay,
                );
              });
        },
        backgroundColor: primary_color,
        child: const Icon(Icons.add),
      );
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDay;

  const _ScheduleList({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDataBase>().watchSchedules(),
              builder: (context, snapshot) {
                print('------원래 데이터------');
                print('${snapshot.data} snapshot.data');
                print('------$selectedDay------');

                List<Schedule> schedules = [];

                if (snapshot.hasData) {
                  schedules = snapshot.data!
                      .where((element) => element.date == selectedDay)
                      .toList();
                }
                // 오늘날짜로 돌아오면 스케쥴이 사라진다. 왜냐하면 기준 시간이 다르기 때문
                // 2022-06-14 00:00:00.000Z <- Z는 UTC 기준으로 0시를 말한다.
                // Z가 안붙어있으면 현지시간을 말한다 ( +- 9시간 )
                print('------필터링------');
                print('${schedules} schedules');
                print('------$selectedDay------');

                return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: 190,
                    itemBuilder: (context, index) {
                      return ScheduleCard(
                          startTime: 8,
                          endTime: 9,
                          content: '프로그래밍 공부하기 $index',
                          color: Colors.red);
                    });
              })),
    );
  }
}
