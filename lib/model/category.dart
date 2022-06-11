import 'package:drift/drift.dart';

class CategoryColors extends Table{
  // category pk
  IntColumn get id => integer().autoIncrement()();

  TextColumn get hexCode => text()();
}
