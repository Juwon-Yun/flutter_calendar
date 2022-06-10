import 'package:flutter/material.dart';
import 'package:flutter_calendar/components/calendar.dart';
import 'package:flutter_calendar/components/today_banner.dart';

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
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
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
            ],
          ),
        ),
      ),
    );
  }

  _onDaySelected(selected, focused) {
    setState(() {
      selectedDay = selected;
      focusedDay = selected;
    });
  }
}
