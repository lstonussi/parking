import 'package:drift/drift.dart';

class ParkingLots extends Table {
  IntColumn get id => integer()();
  TextColumn get plate => text()();
  TextColumn get spaceParkingCode => text()();
  TextColumn get modelCar => text()();
  DateTimeColumn get entryDateTime => dateTime()();
  DateTimeColumn get departureDateTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
