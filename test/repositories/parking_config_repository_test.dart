import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/pages/config/data/repositories/parking_config_repository_impl.dart';

class MockParkingConfigDAO extends Mock implements ParkingConfigDAO {}

void main() {
  late ParkingConfigRepositoryImpl tParkingConfigRepository;
  late ParkingConfigDAO tParkingConfigDAO;
  setUp(
    () {
      tParkingConfigDAO = MockParkingConfigDAO();
      tParkingConfigRepository =
          ParkingConfigRepositoryImpl(parkingConfigDAO: tParkingConfigDAO);
    },
  );

//   group(
//     'getFeed',
//     () {
//       test('Given all params, should return a List of Feeds', () async {
//         expect(response, list);
//       });
//     },
//   );
}
