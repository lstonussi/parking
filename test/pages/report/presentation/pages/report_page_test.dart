import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/report/presentation/pages/report_page.dart';
import 'package:parking/values/app_texts.dart';

DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
void main() {
  const tPlate = 'ABC1234';
  const tSpaceParkingCode = 1;
  const tModelCar = 'Porsche';
  const tEntryDateTime = '26/03/2022 12:53:45';
  const tDepartureHour = '26/03/2022 20:04:12';

  const tPlate1 = 'BBB1234';
  const tSpaceParkingCode1 = 2;
  const tModelCar1 = 'BMW';
  const tEntryDateTime1 = '25/03/2022 15:45:23';
  const tDepartureHour1 = '26/03/2022 14:33:43';

  const tPlate2 = 'CCC1234';
  const tSpaceParkingCode2 = 2;
  const tModelCar2 = 'Volvo';
  const tEntryDateTime2 = '26/03/2022 15:00:23';
  const tDepartureHour2 = '26/03/2022 17:33:53';

  final tParkingSpace = ParkingSpaceModel(
    plate: tPlate,
    spaceParkingCode: tSpaceParkingCode,
    modelCar: tModelCar,
    entryDateTime: dateFormat.parse(tEntryDateTime),
  );

  final tParkingSpace1 = ParkingSpaceModel(
    plate: tPlate1,
    spaceParkingCode: tSpaceParkingCode1,
    modelCar: tModelCar1,
    entryDateTime: dateFormat.parse(tEntryDateTime1),
  );

  final tParkingSpace2 = ParkingSpaceModel(
    plate: tPlate2,
    spaceParkingCode: tSpaceParkingCode2,
    modelCar: tModelCar2,
    entryDateTime: dateFormat.parse(tEntryDateTime2),
  );

  final listParkingSpace = [
    tParkingSpace,
    tParkingSpace1,
  ];
  final listParkingSpaceWithDepartureHour = [
    tParkingSpace,
    tParkingSpace1.copyWith(
      departureDateTime: dateFormat.parse(tDepartureHour1),
    ),
    tParkingSpace2,
  ];

  testWidgets(
    'Should show empty report page',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpace: [],
      );
      // title
      expect(find.byType(Table), findsOneWidget);
      expect(find.text(AppTexts.id), findsOneWidget);
      expect(find.text(AppTexts.spaceParkingCode), findsOneWidget);
      expect(find.text(AppTexts.plate), findsOneWidget);
      expect(find.text(AppTexts.modelCar), findsOneWidget);
      expect(find.text(AppTexts.entryHour), findsOneWidget);
      expect(find.text(AppTexts.departureHour), findsOneWidget);

      final table = find.byWidgetPredicate(
          (Widget widget) => widget is Table && widget.children.length == 1);
      expect(table, findsOneWidget);
    },
  );
  testWidgets(
    'Should show report page with records without departure hour',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpace: listParkingSpace,
      );
      // title
      expect(find.byType(Table), findsOneWidget);
      expect(find.text(AppTexts.id), findsOneWidget);
      expect(find.text(AppTexts.spaceParkingCode), findsOneWidget);
      expect(find.text(AppTexts.plate), findsOneWidget);
      expect(find.text(AppTexts.modelCar), findsOneWidget);
      expect(find.text(AppTexts.entryHour), findsOneWidget);
      expect(find.text(AppTexts.departureHour), findsOneWidget);
      // car 1
      expect(find.text(tSpaceParkingCode.toString()), findsOneWidget);
      expect(find.text(tPlate), findsOneWidget);
      expect(find.text(tModelCar), findsOneWidget);
      expect(find.text(tEntryDateTime), findsOneWidget);
      expect(find.text(tDepartureHour), findsNothing);

      // car 2
      expect(find.text(tSpaceParkingCode1.toString()), findsOneWidget);
      expect(find.text(tPlate1), findsOneWidget);
      expect(find.text(tModelCar1), findsOneWidget);
      expect(find.text(tEntryDateTime1), findsOneWidget);
      expect(find.text(tDepartureHour1), findsNothing);

      final table = find.byWidgetPredicate(
          (Widget widget) => widget is Table && widget.children.length == 3);
      expect(table, findsOneWidget);
    },
  );
  testWidgets(
    'Should show the report page with records, when a parking space was released and was filled again',
    (widgetTester) async {
      await _createWidget(
        widgetTester: widgetTester,
        parkingSpace: listParkingSpaceWithDepartureHour,
      );
      // title
      expect(find.byType(Table), findsOneWidget);
      expect(find.text(AppTexts.id), findsOneWidget);
      expect(find.text(AppTexts.spaceParkingCode), findsOneWidget);
      expect(find.text(AppTexts.plate), findsOneWidget);
      expect(find.text(AppTexts.modelCar), findsOneWidget);
      expect(find.text(AppTexts.entryHour), findsOneWidget);
      expect(find.text(AppTexts.departureHour), findsOneWidget);
      // car 2
      expect(find.text(tDepartureHour1), findsOneWidget);
      // car 3
      expect(find.text(tSpaceParkingCode2.toString()), findsNWidgets(2));
      expect(find.text(tPlate2), findsOneWidget);
      expect(find.text(tModelCar2), findsOneWidget);
      expect(find.text(tEntryDateTime2), findsOneWidget);
      expect(find.text(tDepartureHour2), findsNothing);

      final table = find.byWidgetPredicate(
          (Widget widget) => widget is Table && widget.children.length == 4);
      expect(table, findsOneWidget);
    },
  );
}

Future<void> _createWidget({
  required List<ParkingSpaceModel> parkingSpace,
  required WidgetTester widgetTester,
}) async {
  await widgetTester.pumpWidget(
    MaterialApp(
      home: ReportPage(
        parkingSpace: parkingSpace,
      ),
    ),
  );
  await widgetTester.pump();
}
