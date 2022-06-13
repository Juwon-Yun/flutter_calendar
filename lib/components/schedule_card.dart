import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.content,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: primary_color,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding:const EdgeInsets.all(16),
        // row에서 가장 높이가 큰 위젯만큼 높이가 같게 해주는 위젯
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              SizedBox(width: 16),
              _Content(content: content),
              SizedBox(width: 16),
              _Category(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({Key? key, required this.startTime, required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.w600, color: primary_color, fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${startTime.toString().padLeft(2, '0')}:00', style: textStyle),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
