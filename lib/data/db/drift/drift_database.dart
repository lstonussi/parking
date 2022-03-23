import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:parking/data/db/drift/tables/parking_config.dart';
import 'package:parking/data/db/drift/tables/parking_space.dart';
import 'package:parking/utils/database_util.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    ParkingConfig,
    ParkingSpace,
  ],
)
class Database extends _$Database {
  @visibleForTesting
  Database(QueryExecutor e) : super(e);

  Database._() : super(openConnection());

  // Database.connect(DatabaseConnection c) : super.connect(c);

  static final Database _singleton = Database._();

  static Database get instance => _singleton;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: dataMigrationHandler,
      );

  Future<void> dataMigrationHandler(Migrator migrator) async {
    try {
      debugPrint('#DRIFT: Create DB');
      await migrator.createAll();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

LazyDatabase openConnection() {
  applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(
    () async {
      debugPrint('#DRIFT: OPEN');
      final dbPath = await DatabaseUtil.instance.getDBPath();
      final file = File(dbPath);
      debugPrint('#DRIFT: ${file.absolute}');
      return NativeDatabase(
        file,
        logStatements: kDebugMode,
      );
    },
  );
}
