import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_calendar/components/custom_text_field.dart';
import 'package:flutter_calendar/constants/colors.dart';
import 'package:flutter_calendar/repository/init_db.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;

  const ScheduleBottomSheet({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    // 기기의 소프트웨어가 차지하는 부분
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        // TextField를 제외하고 어딜 누르든 키보드가 사라짐, UX
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.5 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              // textformfield를 위해 감싸는 위젯
              child: Form(
                // form의 컨트롤러
                key: formKey,
                // onChange처럼 Live로 작동함
                // autovalidateMode: AutovalidateMode.always,
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
                    // .g 파일에서 만들어준 타입 CategoryColor
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDataBase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              selectedColorId == null &&
                              snapshot.data!.isNotEmpty) {
                            selectedColorId = snapshot.data![0].id;
                          }

                          return _ColorPicker(
                            colors: snapshot.hasData
                                ? snapshot.data!.map((e) => e).toList()
                                : [],
                            selectedColorId: selectedColorId,
                            // typedef
                            colorIdSetter: (int id) {
                              setState(() {
                                selectedColorId = id;
                              });
                            },
                          );
                        }),
                    const SizedBox(height: 8),
                    _SaveButton(
                      onPressed: onSavePressed,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    // formKey를 생성을 했지만 form위젯과 결합을 안했을때 null이 될 수 있다.
    if (formKey.currentState == null) return;

    // 모든 TextFormField의 validate 옵션이 작동한다.
    // 모두 에러가 없을때 true를 리턴한다.
    if (formKey.currentState!.validate()) {
      // synchronalble 이라서 await안써도됨
      formKey.currentState!.save();

      await GetIt.I<LocalDataBase>().createSchedule(SchedulesCompanion(
        content: Value(content!),
        date: Value(widget.selectedDate),
        startTime: Value(startTime!),
        endTime: Value(endTime!),
        colorId: Value(selectedColorId!),
      ));

      if(!mounted) return;
      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }

  // int와 string을 구분했지만
  // startTime과 endTime은 구분할 방법이 없을까?
  void onFormFieldSaved(val) {
    if (int.tryParse(val) != null) {
      endTime = int.parse(val);
    } else {
      content = val;
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
          style: ElevatedButton.styleFrom(
            primary: primary_color,
          ),
          child: const Text('저장'),
        ))
      ],
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;

  // typeDef
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    Key? key,
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // 왼 오
      spacing: 8,
      // 위 아래
      runSpacing: 10,
      children: colors
          .map((e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(e.hexCode, e.id == selectedColorId)))
          .toList(),
      // [
      //   renderColor(Colors.red),
      //   renderColor(Colors.orange),
      //   renderColor(Colors.yellow),
      //   renderColor(Colors.green),
      //   renderColor(Colors.blue),
      //   renderColor(Colors.indigo),
      //   renderColor(Colors.purple),
      // ],
    );
  }

  Widget renderColor(String color, bool isSelected) => Container(
        decoration: BoxDecoration(
          // 16진수화 => radix : int
          color: Color(int.parse('0xFF$color')),
          shape: BoxShape.circle,
          border:
              isSelected ? Border.all(color: Colors.grey, width: 3.0) : null,
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
