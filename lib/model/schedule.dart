// drift가 sqlite orm한다.
import 'package:drift/drift.dart';

class Schedules extends Table{
  // pk
  IntColumn get id => integer()();

  TextColumn get content => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get startTime => integer()();

  IntColumn get endTime => integer()();

  // Category Color Table Id, fk
  IntColumn get colorId => integer()();

  DateTimeColumn get createdAt => dateTime()();
}