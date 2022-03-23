import 'package:drift/drift.dart';

class ParkingSpace extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get plate => text()();
  IntColumn get spaceParkingCode => integer()();
  TextColumn get modelCar => text()();
  DateTimeColumn get entryDateTime => dateTime()();
  DateTimeColumn get departureDateTime => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
