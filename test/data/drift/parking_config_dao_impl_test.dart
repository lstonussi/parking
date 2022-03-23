import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking/data/db/drift/drift_database.dart' as db;
import 'package:parking/data/db/drift/parking_config_dao_impl.dart';
import 'package:parking/domain/models/parking_config.dart';

void main() {
  late db.Database database;
  late ParkingConfigDaoImpl parkingConfigDaoImpl;
  ParkingConfig parkingConfig;
  const tName = 'John`s Parking';
  const tQuatitySpace = 50;
  setUp(
    () {
      database = db.Database(NativeDatabase.memory());
      parkingConfigDaoImpl = ParkingConfigDaoImpl(
        database,
      );
    },
  );

  tearDown(
    () => database.close(),
  );

  test(
    'Should Insert Parking Config and should return parking config',
    () async {
      parkingConfig = await parkingConfigDaoImpl.getConfig();
      expect(parkingConfig.id, null);

      await parkingConfigDaoImpl.insert(
        name: tName,
        quantitySpace: tQuatitySpace,
      );

      parkingConfig = await parkingConfigDaoImpl.getConfig();

      expect(parkingConfig.id, 1);
      expect(parkingConfig.name, tName);
    },
  );
}
