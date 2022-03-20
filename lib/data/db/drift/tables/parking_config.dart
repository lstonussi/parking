import 'package:drift/drift.dart';

class ParkingConfig extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get spaceQuantity => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
