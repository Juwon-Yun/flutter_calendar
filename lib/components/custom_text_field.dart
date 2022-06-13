import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField({Key? key, required this.label, required this.isTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: primary_color, fontWeight: FontWeight.w600),
        ),
        isTime ? renderTextField() : Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() => TextFormField(
        // onChanged: (String? inputValue){
          // print(inputValue);
        // },
        // form으로 input value를 통합해서 관리한다.
        validator: (String? value){
          // null이 반환되면 에러가 없다.
          // 에러가 있으면 에러를 문자열로 반환한다.

          if (value == null || value.isEmpty) {
            return '값을 입력해주세요';
          }
          return null;
        },

        // 1인 경우 1줄로, null인 경우 너비 넘어가면 줄바꿈
        // maxLines: 1,
        maxLines: isTime ? 1 : null,
        // 세로로 최대한으로 늘린다.
        expands: !isTime,
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        inputFormatters: isTime
            ? [
                // 숫자만 타이밍 가능하게
                FilteringTextInputFormatter.digitsOnly
              ]
            : [],
        // 커서깜빡임
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
        ),
      );
}
