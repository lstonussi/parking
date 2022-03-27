import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking/data/db/drift/drift_database.dart' as db;
import 'package:parking/data/db/drift/parking_space_dao_impl.dart';
import 'package:parking/domain/models/parking_space_model.dart';

void main() {
  late db.Database database;
  late ParkingSpaceDaoImpl parkingSpaceDaoImpl;
  List<ParkingSpaceModel> listParkingSpaceModel;
  const tPlate = 'AAA1234';
  const tModelCar = 'Mustang';
  const tSpaceParkingCode = 1;

  const tPlate1 = 'BBB1234';
  const tModelCar1 = 'Porsche';
  const tSpaceParkingCode1 = 2;

  final tParkingSpace = ParkingSpaceModel(
    plate: tPlate,
    spaceParkingCode: tSpaceParkingCode,
    modelCar: tModelCar,
    entryDateTime: DateTime.now(),
  );

  final tParkingSpace1 = ParkingSpaceModel(
    plate: tPlate1,
    spaceParkingCode: tSpaceParkingCode1,
    modelCar: tModelCar1,
    entryDateTime: DateTime.now(),
  );
  setUp(
    () {
      database = db.Database(NativeDatabase.memory());
      parkingSpaceDaoImpl = ParkingSpaceDaoImpl(
        database,
      );
    },
  );

  tearDown(
    () => database.close(),
  );

  test(
    'Should Insert ParkingSpace and should return a list of ParkingSpace',
    () async {
      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.isEmpty, true);
      await parkingSpaceDaoImpl.insert(parkingSpaceModel: tParkingSpace);
      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.isEmpty, false);
      expect(listParkingSpaceModel.length, 1);
      expect(listParkingSpaceModel[0].modelCar, tModelCar);
      expect(listParkingSpaceModel[0].plate, tPlate);
      expect(listParkingSpaceModel[0].spaceParkingCode, tSpaceParkingCode);
    },
  );
  test(
    'Should delete all parking space',
    () async {
      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.isEmpty, true);

      await parkingSpaceDaoImpl.insert(parkingSpaceModel: tParkingSpace);
      await parkingSpaceDaoImpl.insert(parkingSpaceModel: tParkingSpace1);
      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();

      expect(listParkingSpaceModel.isEmpty, false);
      expect(listParkingSpaceModel.length, 2);
      await parkingSpaceDaoImpl.deleteAll();

      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.isEmpty, true);
      expect(listParkingSpaceModel.length, 0);
    },
  );
  test(
    'Should update departure date parking space',
    () async {
      final tId = await parkingSpaceDaoImpl.insert(
        parkingSpaceModel: tParkingSpace,
      );
      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.length, 1);
      expect(listParkingSpaceModel[0].departureDateTime == null, true);

      await parkingSpaceDaoImpl.updateDate(
          id: tId, departureTime: DateTime.now());

      listParkingSpaceModel = await parkingSpaceDaoImpl.getAll();
      expect(listParkingSpaceModel.length, 1);
      expect(listParkingSpaceModel[0].id, tId);
      expect(listParkingSpaceModel[0].departureDateTime == null, false);
    },
  );
}
