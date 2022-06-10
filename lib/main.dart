import 'package:flutter/material.dart';
import 'package:flutter_calendar/screen/main_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()  {
  // flutter 프레임웤이 준비될떄까지 기다릴 수 있다.
  WidgetsFlutterBinding.ensureInitialized();

  initController();

  runApp(const MainScreen());
}

initController() async {
  await initializeDateFormatting();
}


