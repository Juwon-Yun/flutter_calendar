import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/constants/colors.dart';
import 'package:flutter_calendar/repository/init_db.dart';
import 'package:flutter_calendar/screen/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // flutter 프레임웤이 준비될떄까지 기다릴 수 있다.
  WidgetsFlutterBinding.ensureInitialized();

  initController();

  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      debugShowCheckedModeBanner: false,
      home: MainScreen()));
}

initController() async {
  await initializeDateFormatting();
  final database = LocalDataBase();
  final colors = await database.getCategoryColors();

  if (colors.isEmpty) {
    for (String hexcode in default_colors) {
      await database.createCategoryColor(
          // CategoryColorsCompanion(id: , hexCode: );
          CategoryColorsCompanion(hexCode: Value(hexcode)));
    }
  }
  // [CategoryColor(id: 1, hexCode: F44336),
  // CategoryColor(id: 2, hexCode: FF9800),
  // CategoryColor(id: 3, hexCode: FFEB3B),
  // CategoryColor(id: 4, hexCode: FCAF50),
  // CategoryColor(id: 5, hexCode: 2196F3),
  // CategoryColor(id: 6, hexCode: 3F51B5),
  // CategoryColor(id: 7, hexCode: 9C27B0)]
  print(await database.getCategoryColors());
}
