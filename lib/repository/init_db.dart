import 'dart:io';

// private는 불러오지 못함
import 'package:drift/drift.dart';

// NativeDatabase()가 최신버전에서는 안나와서 마이그레이션함,
// docs에서도 그냥 쓰는데 안되는 이유는 모르겠다.
import 'package:drift/native.dart';

import 'package:flutter_calendar/model/category.dart';
import 'package:flutter_calendar/model/schedule.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// private 값까지 가져올 수 있다. 같은 파일로 인식하는 느낌.
part 'init_db.g.dart';

// _$ 클래스는 drift가 runner로 생성해준다.
@DriftDatabase(
  tables: [
    // 사용할 model class만
    Schedules,
    CategoryColors,
  ],
)
class LocalDataBase extends _$LocalDataBase{
  LocalDataBase() : super(_openConnection());
}
//
// LazyDatabase _openConnection(){
//   // db file 생성 위치
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     // dbFolder의 경로 주소와 db.sqlite를 붙여준다.
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//
//     return NativeDatabase(file);
//   });
// }

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}