import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_space_dao.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/data/repositories/parking_space_repository_impl.dart';
import 'package:parking/pages/home/domain/repositories/parking_space_repository.dart';

class MockParkingSpaceDAO extends Mock implements ParkingSpaceDAO {}

void main() {
  late ParkingSpaceRepository parkingSpaceRepository;
  late ParkingSpaceDAO mockParkingSpaceDAO;

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
      mockParkingSpaceDAO = MockParkingSpaceDAO();
      parkingSpaceRepository =
          ParkingSpaceRepositoryImpl(parkingSpaceDAO: mockParkingSpaceDAO);
    },
  );

  group(
    'Insert Group',
    () {
      test('Should insert a parking space', () async {
        when(
          () => mockParkingSpaceDAO.insert(
            tParkingSpaceModel,
          ),
        ).thenAnswer(
          (invocation) => Future.value(1),
        );

        final resultOrFailure = await parkingSpaceRepository.insert(
            parkingSpaceModel: tParkingSpaceModel);

        expect(resultOrFailure.isRight(), isTrue);
      });
      test(
        'Should trying insert, but, return a InsertException',
        () async {
          when(
            () => mockParkingSpaceDAO.insert(
              tParkingSpaceModel,
            ),
          ).thenThrow(
            InsertException(),
          );

          final resultOrFailure = await parkingSpaceRepository.insert(
              parkingSpaceModel: tParkingSpaceModel);

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
      test(
        'Should trying insert, but, return a GenericException',
        () async {
          when(
            () => mockParkingSpaceDAO.insert(
              tParkingSpaceModel,
            ),
          ).thenThrow(
            GenericException(message: 'GenericException'),
          );

          final resultOrFailure = await parkingSpaceRepository.insert(
            parkingSpaceModel: tParkingSpaceModel,
          );

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
    },
  );
  group(
    'Get parking space',
    () {
      test('Should return a parking space', () async {
        when(() => mockParkingSpaceDAO.getAll()).thenAnswer(
          (invocation) => Future.value(
            [
              tParkingSpaceModel,
              tParkingSpaceModel1,
            ],
          ),
        );

        final resultOrFailure = await parkingSpaceRepository.getAll();

        expect(resultOrFailure.isRight(), isTrue);
      });
      test(
        'Should return a parking space, but, return a SelectException',
        () async {
          when(
            () => mockParkingSpaceDAO.getAll(),
          ).thenThrow(
            SelectException(),
          );

          final resultOrFailure = await parkingSpaceRepository.getAll();

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
      test(
        'Should return a parking space, but, return a GenericException',
        () async {
          when(
            () => mockParkingSpaceDAO.getAll(),
          ).thenThrow(
            GenericException(message: 'GenericException'),
          );

          final resultOrFailure = await parkingSpaceRepository.getAll();

          expect(resultOrFailure.isLeft(), isTrue);
        },
      );
    },
  );
}
