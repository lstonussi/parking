import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/domain/models/parking_config.dart';
import 'package:parking/pages/config/data/repositories/parking_config_repository_impl.dart';
import 'package:parking/pages/config/domain/repositories/parking_config_repository.dart';

import 'parking_config_repository_impl_test.mocks.dart';

@GenerateMocks([
  ParkingConfigDAO,
])
void main() {
  late ParkingConfigRepository parkingConfigRepository;
  late ParkingConfigDAO mockParkingConfigDAO;
  const tId = 1;
  const tName = 'John`s Parking';
  const tQuantitySpace = 50;
  setUp(
    () {
      mockParkingConfigDAO = MockParkingConfigDAO();
      parkingConfigRepository =
          ParkingConfigRepositoryImpl(parkingConfigDAO: mockParkingConfigDAO);
    },
  );

  group(
    'Insert Group',
    () {
      test('Should insert a name and quantity of parking space', () async {
        when(
          mockParkingConfigDAO.insert(
            name: tName,
            quantitySpace: tQuantitySpace,
          ),
        ).thenAnswer(
          (invocation) => Future.value(1),
        );

        final resultOrFailure = await parkingConfigRepository.insert(
          name: tName,
          quantitySpace: tQuantitySpace,
        );

        expect(resultOrFailure.isRight(), isTrue);
      });
      test(
        'Should trying insert, but, return a InsertException',
        () async {
          when(
            mockParkingConfigDAO.insert(
              name: tName,
              quantitySpace: tQuantitySpace,
            ),
          ).thenThrow(
            InsertException(),
          );

          final resultOrFailure = await parkingConfigRepository.insert(
            name: tName,
            quantitySpace: tQuantitySpace,
          );

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
      test(
        'Should trying insert, but, return a GenericException',
        () async {
          when(
            mockParkingConfigDAO.insert(
              name: tName,
              quantitySpace: tQuantitySpace,
            ),
          ).thenThrow(
            GenericException(message: 'GenericException'),
          );

          final resultOrFailure = await parkingConfigRepository.insert(
            name: tName,
            quantitySpace: tQuantitySpace,
          );

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
    },
  );
  group(
    'Get Config Group',
    () {
      test('Should return a parking config', () async {
        when(
          mockParkingConfigDAO.getConfig(),
        ).thenAnswer(
          (invocation) => Future.value(
            const ParkingConfig(
              id: tId,
              name: tName,
              spaceQuantity: tQuantitySpace,
            ),
          ),
        );

        final resultOrFailure = await parkingConfigRepository.getConfig();

        expect(resultOrFailure.isRight(), isTrue);
      });
      test(
        'Should return a parking config, but, return a SelectException',
        () async {
          when(
            mockParkingConfigDAO.getConfig(),
          ).thenThrow(
            SelectException(),
          );

          final resultOrFailure = await parkingConfigRepository.getConfig();

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
      test(
        'Should return a parking config, but, return a GenericException',
        () async {
          when(
            mockParkingConfigDAO.getConfig(),
          ).thenThrow(
            GenericException(message: 'GenericException'),
          );

          final resultOrFailure = await parkingConfigRepository.getConfig();

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
    },
  );
}
