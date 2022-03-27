import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/domain/repositories/parking_space_repository.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'home_bloc_test.mocks.dart';

DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
@GenerateMocks([
  ParkingSpaceRepository,
])
const tId = 1;
const tSpaceParkingCode = 1;
const tPlate = 'AAA1234';
const tModelCar = 'Mustang';
final _tEntryDateTime = dateFormat.parse('25/03/2022 15:45:23');
final _tDepartureDateTime = dateFormat.parse('25/03/2022 20:14:45');

final tParkingSpaceModel = ParkingSpaceModel(
  plate: tPlate,
  spaceParkingCode: tSpaceParkingCode,
  modelCar: tModelCar,
  entryDateTime: _tEntryDateTime,
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
  entryDateTime: _tEntryDateTime,
);

void main() {
  late ParkingSpaceRepository mockParkingSpaceRepository;
  late HomeBloc subject;
  setUp(
    () {
      mockParkingSpaceRepository = MockParkingSpaceRepository();
      subject = HomeBloc(
        parkingSpaceRepository: mockParkingSpaceRepository,
      );
    },
  );

  blocTest(
    'emits [] when nothing is called',
    build: () => subject,
    expect: () => const <Idle>[],
  );

  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, LoadedParkingSpace] when is called',
    setUp: () {
      when(mockParkingSpaceRepository.getAll()).thenAnswer(
        (invocation) async => Right([
          tParkingSpaceModel,
          // tParkingSpaceModel1,
        ]),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(const RefreshList()),
    expect: () => [
      isA<Loading>(),
      isA<LoadedParkingSpace>(),
    ],
  );
  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, Error] when is called',
    setUp: () {
      when(mockParkingSpaceRepository.getAll()).thenAnswer(
        (invocation) async => Left(
          SelectDataBaseFailure(),
        ),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(const RefreshList()),
    expect: () => [
      isA<Loading>(),
      isA<Error>(),
    ],
  );
  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, NewCarEntry] when is called',
    setUp: () {
      when(
        mockParkingSpaceRepository.insert(
          parkingSpaceModel: tParkingSpaceModel,
        ),
      ).thenAnswer(
        (invocation) async => Future.value(const Right(1)),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(
      NewCarEntry(
        entryHour: _tEntryDateTime,
        modelCar: tModelCar,
        plate: tPlate,
        spaceParkingCode: tSpaceParkingCode,
      ),
    ),
    expect: () => [
      isA<Loading>(),
      isA<SavedNewCar>(),
    ],
  );
  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, Error] when is called',
    setUp: () {
      when(
        mockParkingSpaceRepository.insert(
          parkingSpaceModel: tParkingSpaceModel,
        ),
      ).thenAnswer(
        (invocation) async => Left(
          InsertDataBaseFailure(),
        ),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(
      NewCarEntry(
        entryHour: _tEntryDateTime,
        modelCar: tModelCar,
        plate: tPlate,
        spaceParkingCode: tSpaceParkingCode,
      ),
    ),
    expect: () => [
      isA<Loading>(),
      isA<Error>(),
    ],
  );
  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, DepartureCar] when is called',
    setUp: () {
      when(
        mockParkingSpaceRepository.updateDate(
          id: tId,
          departureTime: _tDepartureDateTime,
        ),
      ).thenAnswer(
        (invocation) async => Future.value(
          const Right(1),
        ),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(
      DepartureCar(
        id: 1,
        departureDateTime: _tDepartureDateTime,
      ),
    ),
    expect: () => [
      isA<Loading>(),
      isA<UpdatedDate>(),
    ],
  );
  blocTest<HomeBloc, HomeState>(
    'should emits [Loading, Error] when is called',
    setUp: () {
      when(
        mockParkingSpaceRepository.updateDate(
          id: tId,
          departureTime: _tDepartureDateTime,
        ),
      ).thenAnswer(
        (invocation) async => Left(
          UpdateDataBaseFailure(),
        ),
      );
    },
    build: () => subject,
    act: (bloc) => bloc.add(
      DepartureCar(
        id: 1,
        departureDateTime: _tDepartureDateTime,
      ),
    ),
    expect: () => [
      isA<Loading>(),
      isA<Error>(),
    ],
  );
}
