import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField(
      {Key? key,
      required this.label,
      required this.isTime,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: primary_color, fontWeight: FontWeight.w600),
        ),
        isTime ? renderTextField() : Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() => TextFormField(
        // TextFormField를 감싸고 있는 Form Widget에서 Save 함수를 호출했을때 onSaved가 실행됨
        onSaved: onSaved,
        // onChanged: (String? inputValue){
        // print(inputValue);
        // },
        // form으로 input value를 통합해서 관리한다.
        validator: (String? value) {
          // null이 반환되면 에러가 없다.
          // 에러가 있으면 에러를 문자열로 반환한다.

          if (value == null || value.isEmpty) {
            return '값을 입력해주세요.';
          }

          if (isTime) {
            int time = int.parse(value);

            if (time < 0) {
              return '0 이상의 숫자를 입력해주세요.';
            }

            if (time > 24) {
              return '24 이하의 숫자를 입력해주세요.';
            }
          } else {
            // if(value.length > 500){
            //   return '500자 이하의 글자를 입력해주세요.';
            // }
          }

          return null;
        },

        // 1인 경우 1줄로, null인 경우 너비 넘어가면 줄바꿈
        // maxLines: 1,
        maxLines: isTime ? 1 : null,
        // 세로로 최대한으로 늘린다.
        expands: !isTime,
        maxLength: isTime ? null : 500,
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        inputFormatters: isTime
            ? [
                // 숫자만 타이핑 가능하게
                FilteringTextInputFormatter.digitsOnly
              ]
            : [],
        // 커서깜빡임
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          // 접미사 suffix, 접두사 preffix
          suffixText: isTime ? '시' : null,
        ),
      );
}
