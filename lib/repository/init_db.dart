import 'dart:io';

// flutter pub run build_runner build
// private는 불러오지 못함
import 'package:drift/drift.dart';

// NativeDatabase()가 최신버전에서는 안나와서 마이그레이션함,
// docs에서도 그냥 쓰는데 안되는 이유는 모르겠다.
import 'package:drift/native.dart';

import 'package:flutter_calendar/model/category.dart';
import 'package:flutter_calendar/model/schedule.dart';
import 'package:flutter_calendar/model/schedule_with_color.dart';
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
class LocalDataBase extends _$LocalDataBase {
  LocalDataBase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // select => stream or future
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // Stream으로 값들이 지속적으로 업데이트된 값을 받을 수 있다.
  // where은 void function이기떄문에

  // 모든값이 삭제되는 쿼리
  // removeSchedule() => delete(schedules).go();
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // Stream<List<Schedule>> watchSchedules(DateTime date) {
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    // inner join
    final query = select(schedules).join([
      // 조인할 테이블, 조인 조건
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    // 실제 테이블을 명시해주어야한다.
    // query.where((tbl) => tbl.date.equals(date));
    query.where(schedules.date.equals(date));

    query.orderBy([
      // schedules의 시작시간을 기준으로 오름차순으로 정렬
      OrderingTerm.asc(schedules.startTime)
    ]);

    // stream의 map임, rows => filter된 모든 데이터
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );

    // ..을 이용해 생성자 생략을 한다.
    // 함수가 실행이된 대상이 리턴이 된다.
    // 함수 결과가 리턴되는것이 아닌
    // return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  }

  @override
  // table state version
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // db file 생성 위치
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // dbFolder의 경로 주소와 db.sqlite를 붙여준다.
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
