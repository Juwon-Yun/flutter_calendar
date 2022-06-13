import 'package:flutter/material.dart';
import 'package:flutter_calendar/components/custom_text_field.dart';
import 'package:flutter_calendar/constants/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    // 기기의 소프트웨어가 차지하는 부분
    final bottomInset = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return GestureDetector(
      onTap: () {
        // TextField를 제외하고 어딜 누르든 키보드가 사라짐, UX
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              // textformfield를 위해 감싸는 위젯
              child: Form(
                // form의 컨트롤러
                key: formKey,
                // onChange처럼 Live로 작동함
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (newValue) {
                        // validator에서 이미 null 검증을 했기 때문에 null 체크하지 않아도된다.
                        startTime = int.parse(newValue!);
                      },
                      onEndSaved: (String? newValue) =>
                          onFormFieldSaved(newValue),
                    ),
                    const SizedBox(height: 16),
                    _Content(
                        onContentSaved: (String? newValue) =>
                            onFormFieldSaved(newValue),
                    ),
                    const SizedBox(height: 16),
                    _ColorPicker(),
                    const SizedBox(height: 8),
                    _SaveButton(onPressed: onSavePressed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey를 생성을 했지만 form위젯과 결합을 안했을때 null이 될 수 있다.
    if (formKey.currentState == null) return;

    // 모든 TextFormField의 validate 옵션이 작동한다.
    // 모두 에러가 없을때 true를 리턴한다.
    if (formKey.currentState!.validate()) {
      print('에러가 없습니다.');
      // synchronalble 이라서 await안써도됨
      formKey.currentState!.save();
      print(startTime);
      print(endTime);
      print(content);
    } else {
      print('에러가 있습니다.');
    }
  }
  
  // int와 string을 구분했지만 
  // startTime과 endTime은 구분할 방법이 없을까?
  void onFormFieldSaved(val) {
    if (int.tryParse(val) != null) {
      endTime = int.parse(val);
      print('onFormField int $val');
    } else {
      content = val;
      print('onFormField text $val');
    }
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              child: const Text('저장'),
              style: ElevatedButton.styleFrom(
                primary: primary_color,
              ),
            ))
      ],
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 왼 오
      spacing: 8,
      // 위 아래
      runSpacing: 10,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) =>
      Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        width: 32,
        height: 32,
      );
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onContentSaved;

  const _Content({
    Key? key,
    required this.onContentSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        isTime: false,
        label: '내용',
        onSaved: onContentSaved,
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    Key? key,
    required this.onStartSaved,
    required this.onEndSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              isTime: true,
              label: '시작 시간',
              onSaved: onStartSaved,
            )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
              isTime: true,
              label: '마감 시간',
              onSaved: onEndSaved,
            )),
      ],
    );
  }
}
