import 'package:flutter_test/flutter_test.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';

void main() {
  late ParkingSpaceNotifier parkingSpaceNotifier;
  List<ParkingSpaceModel> listParkingSpaceModel;
  int index = -1;
  const tId = 1;
  const tSpaceParkingCode = 1;
  const tPlate = 'AAA1234';
  const tModelCar = 'Mustang';

  final tParkingSpaceModel = ParkingSpaceModel(
    id: tId,
    plate: tPlate,
    spaceParkingCode: tSpaceParkingCode,
    modelCar: tModelCar,
    entryDateTime: DateTime.now(),
  );

  const tId1 = 2;
  const tSpaceParkingCode1 = 2;
  const tPlate1 = 'BBB1234';
  const tModelCar1 = 'Porshe';

  final tParkingSpaceModel1 = ParkingSpaceModel(
    id: tId1,
    plate: tPlate1,
    spaceParkingCode: tSpaceParkingCode1,
    modelCar: tModelCar1,
    entryDateTime: DateTime.now(),
  );

  setUp(
    () {
      parkingSpaceNotifier = ParkingSpaceNotifier();
    },
  );

  test(
    'Update List - onListRecieve',
    () {
      listParkingSpaceModel = parkingSpaceNotifier.list;
      expect(listParkingSpaceModel.isNotEmpty, false);
      parkingSpaceNotifier.onListRecieve(
        [
          tParkingSpaceModel,
          tParkingSpaceModel1,
        ],
      );
      listParkingSpaceModel = parkingSpaceNotifier.list;
      expect(listParkingSpaceModel.isNotEmpty, true);
    },
  );
  test(
    'Verify parking space in use - verifyParkingSpace',
    () {
      listParkingSpaceModel = parkingSpaceNotifier.list;
      expect(listParkingSpaceModel.isEmpty, true);
      index = parkingSpaceNotifier.verifyParkingSpace(index: 1);
      expect(index == -1, true);
      parkingSpaceNotifier.onListRecieve(
        [
          tParkingSpaceModel,
          tParkingSpaceModel1,
        ],
      );
      index = parkingSpaceNotifier.verifyParkingSpace(index: 0);
      expect(index == -1, false);
      index = parkingSpaceNotifier.verifyParkingSpace(index: 1);
      expect(index == -1, false);
      index = parkingSpaceNotifier.verifyParkingSpace(index: 2);
      expect(index == -1, true);
    },
  );
}
