import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:parking/data/db/dao/parking_space_dao.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/data/repositories/parking_space_repository_impl.dart';
import 'package:parking/pages/home/domain/repositories/parking_space_repository.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';
import 'package:parking/pages/home/presentation/pages/home_page.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_grid_widget.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_widget.dart';
import 'package:parking/pages/report/presentation/pages/report_page.dart';

import 'package:provider/provider.dart';

import 'home_page_test.mocks.dart';

DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

class MockContext extends Mock implements BuildContext {}

@GenerateMocks([
  // ParkingSpaceNotifier,
  ParkingSpaceDAO,
])
late ParkingSpaceRepository parkingSpaceRepository;
late ParkingSpaceNotifier parkingSpaceNotifier;
late HomeBloc homeBloc;
late Stream<HomeState> mockStream;
late StreamSubscription<HomeState> mockStreamSubscription;
late MockParkingSpaceDAO mockParkingSpaceDAO;
const tPlate = 'AAA1234';
const tModelCar = 'Mustang';
const tSpaceParkingCode = 1;
const tEntryDateTime = '26/03/2022 12:53:45';
const tDepartureHour = '26/03/2022 20:04:12';

const tQuantitySpace = 20;
final tParkingSpace = ParkingSpaceModel(
  id: 1,
  plate: tPlate,
  spaceParkingCode: tSpaceParkingCode,
  modelCar: tModelCar,
  entryDateTime: dateFormat.parse(tEntryDateTime),
);
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  const tName = 'Parking Test';

  setUp(
    () {
      parkingSpaceNotifier = ParkingSpaceNotifier();
      mockParkingSpaceDAO = MockParkingSpaceDAO();
      parkingSpaceRepository =
          ParkingSpaceRepositoryImpl(parkingSpaceDAO: mockParkingSpaceDAO);
      _createBasicsStubs();
      homeBloc = HomeBloc(parkingSpaceRepository: parkingSpaceRepository);
    },
  );

  testWidgets(
    'Should show grid and click in free parking space',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpaceRepository: parkingSpaceRepository,
        parkingSpaceNotifier: parkingSpaceNotifier,
        homeBloc: homeBloc,
        name: tName,
        tQuantitySpace: tQuantitySpace,
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ParkingSpaceGrid), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final finder = find.byWidgetPredicate(
        (widget) => widget is ParkingSpace && widget.index == 1,
      );

      await widgetTester.tap(finder);
      await widgetTester.pump();

      expect(find.byType(TextFormField), findsNWidgets(3));
    },
  );
  testWidgets(
    'Should show grid and click in parking space occupied',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpaceRepository: parkingSpaceRepository,
        parkingSpaceNotifier: parkingSpaceNotifier,
        homeBloc: homeBloc,
        name: tName,
        tQuantitySpace: tQuantitySpace,
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ParkingSpaceGrid), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final finder = find.byWidgetPredicate(
        (widget) => widget is ParkingSpace && widget.index == 0,
      );

      await widgetTester.tap(finder);
      await widgetTester.pump();

      expect(find.byType(TextFormField), findsNothing);
    },
  );

  testWidgets(
    'Should show grid detail view',
    (widgetTester) async {
      widgetTester.binding.window.physicalSizeTestValue =
          const Size(2960, 1440);
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpaceRepository: parkingSpaceRepository,
        parkingSpaceNotifier: parkingSpaceNotifier,
        homeBloc: homeBloc,
        name: tName,
        tQuantitySpace: tQuantitySpace,
      );

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ParkingSpaceGrid), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final finder = find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.text_increase,
      );

      final parkingSpace = find.byWidgetPredicate(
        (widget) => widget is ParkingSpace,
      );

      expect(parkingSpace, findsNWidgets(6));

      await widgetTester.tap(finder);
      await widgetTester.pump();

      expect(parkingSpace, findsNWidgets(0));
      await widgetTester.tap(finder);

      await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      expectLater(parkingSpace, findsNWidgets(6));
    },
  );
  testWidgets(
    'Should show Report Page',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpaceRepository: parkingSpaceRepository,
        parkingSpaceNotifier: parkingSpaceNotifier,
        homeBloc: homeBloc,
        name: tName,
        tQuantitySpace: tQuantitySpace,
      );
      final icon = find.byWidgetPredicate(
        (widget) =>
            widget is Icon && widget.icon == Icons.insert_chart_outlined_sharp,
      );
      expect(icon, findsOneWidget);
      await widgetTester.tap(icon);
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      expectLater(find.byType(ReportPage), findsOneWidget);
    },
  );
  testWidgets(
    'Should show new car bottom sheet',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpaceRepository: parkingSpaceRepository,
        parkingSpaceNotifier: parkingSpaceNotifier,
        homeBloc: homeBloc,
        name: tName,
        tQuantitySpace: tQuantitySpace,
      );
      final icon = find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == Icons.add,
      );
      await widgetTester.tap(icon);
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      expectLater(find.byType(TextFormField), findsNWidgets(3));
    },
  );
}

void _createBasicsStubs() async {
  when(
    mockParkingSpaceDAO.getAll(),
  ).thenAnswer(
    (invocation) async => Future.value([tParkingSpace]),
  );
}

Future<void> _createWidget({
  required WidgetTester widgetTester,
  required int tQuantitySpace,
  required ParkingSpaceRepository parkingSpaceRepository,
  required ParkingSpaceNotifier parkingSpaceNotifier,
  required HomeBloc homeBloc,
  required String name,
}) async {
  await widgetTester.pumpWidget(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ParkingSpaceNotifier>.value(
            value: parkingSpaceNotifier,
          ),
          RepositoryProvider<ParkingSpaceRepository>.value(
            value: parkingSpaceRepository,
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              parkingSpaceRepository: context.read<ParkingSpaceRepository>(),
            )..add(const RefreshList()),
          ),
        ],
        child: HomePage(
          name: name,
          quantitySpace: tQuantitySpace,
        ),
      ),
    ),
  );
  await widgetTester.pump();
}
