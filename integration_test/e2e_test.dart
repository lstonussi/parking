import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:parking/main.dart' as app;
import 'package:parking/pages/home/presentation/widgets/parking_space_grid_widget.dart';
import 'package:parking/values/app_texts.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Test App',
    (WidgetTester tester) async {
      app.main();
      FlutterError.onError = (_) => Null;
      await tester.pumpAndSettle();

      const parkingName = 'John`s Parking';
      const parkingQuantity = 20;
      //Init config
      final nameKey = find.byKey(const Key('ConfigPageParkingName'));
      final quantityKey = find.byKey(const Key('ConfigPageParkingQuantity'));
      final saveKey = find.byKey(const Key('ConfigPageParkingSave'));

      await tester.tap(nameKey);
      await tester.enterText(nameKey, parkingName);
      await tester.pumpAndSettle();
      await tester.enterText(quantityKey, parkingQuantity.toString());
      await tester.pumpAndSettle();
      await tester.tap(saveKey);
      await tester.pumpAndSettle();
      //End config

      //Register finder in entryBottomSheet

      final entryBottomSheetPlate =
          find.byKey(const Key('EntryBottomSheetPlate'));
      final entryBottomSheetModelCar =
          find.byKey(const Key('EntryBottomSheetModelCar'));
      final entryBottomSheetParkingCode =
          find.byKey(const Key('EntryBottomSheetParkingCode'));
      final saveEntryKey = find.byKey(const Key('EntrySave'));

      //Insert1
      final parkingSpace5 = find.byKey(const Key('ParkingSpaceColor5'));
      await tester.tap(parkingSpace5);
      await tester.pumpAndSettle();

      await tester.tap(entryBottomSheetPlate);
      await tester.enterText(entryBottomSheetPlate, 'ABC1234');
      await tester.pumpAndSettle();
      await tester.enterText(entryBottomSheetModelCar, 'Porshe');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();

      //Insert2
      final parkingSpace0 = find.byKey(const Key('ParkingSpaceColor0'));
      await tester.tap(parkingSpace0);
      await tester.pumpAndSettle();

      await tester.tap(entryBottomSheetPlate);
      await tester.enterText(entryBottomSheetPlate, 'BBB4567');
      await tester.pumpAndSettle();
      await tester.enterText(entryBottomSheetModelCar, 'BMW');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();

      // await Future.delayed(const Duration(milliseconds: 2000));
      //Scroll until find
      final parkingSpace18 = find.byKey(const Key('ParkingSpaceColor18'));
      final listFinder = find.byType(Scrollable);

      await tester.scrollUntilVisible(
        parkingSpace18,
        500.0,
        scrollable: listFinder,
      );
      // await Future.delayed(const Duration(milliseconds: 2000));

      //Insert3
      await tester.tap(parkingSpace18);
      await tester.pumpAndSettle();
      await tester.tap(entryBottomSheetPlate);
      await tester.enterText(entryBottomSheetPlate, 'CCC8901');
      await tester.pumpAndSettle();
      await tester.enterText(entryBottomSheetModelCar, 'Volvo');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();

      //Increase Text
      final increaseTextFinder =
          find.byKey(const Key('HomePageIconButtonTextIncrease'));
      await tester.tap(increaseTextFinder);
      await tester.pumpAndSettle();
      // await Future.delayed(const Duration(milliseconds: 2000));
      await tester.tap(increaseTextFinder);
      await tester.pumpAndSettle();
      // await Future.delayed(const Duration(milliseconds: 2000));

      //Insert new car through add button
      final homePageAddButton = find.byKey(const Key('HomePageIconButtonAdd'));
      await tester.tap(homePageAddButton);
      await tester.pumpAndSettle();
      await tester.tap(entryBottomSheetPlate);
      await tester.enterText(entryBottomSheetPlate, 'DDD2345');
      await tester.tap(entryBottomSheetParkingCode);
      await tester.enterText(entryBottomSheetParkingCode, '3');
      await tester.pumpAndSettle();
      await tester.enterText(entryBottomSheetModelCar, 'Ford');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();

      // Insert new car in occupied parking space through add button
      await tester.tap(homePageAddButton);
      await tester.pumpAndSettle();
      await tester.tap(entryBottomSheetPlate);
      await tester.enterText(entryBottomSheetPlate, 'EEE9393');
      await tester.tap(entryBottomSheetParkingCode);
      await tester.enterText(entryBottomSheetParkingCode, '6');
      await tester.pumpAndSettle();
      await tester.enterText(entryBottomSheetModelCar, 'Peugeout');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();

      // await Future.delayed(const Duration(milliseconds: 2000));
      expect(find.text(AppTexts.parkingSpaceOccupied), findsOneWidget);

      await tester.tap(find.text(AppTexts.parkingSpaceOccupied));
      await tester.tap(entryBottomSheetParkingCode);
      await tester.enterText(entryBottomSheetParkingCode, '7');
      await tester.pumpAndSettle();
      await tester.tap(saveEntryKey);
      await tester.pumpAndSettle();
      //Go to report page
      final reportPageButtonFinder =
          find.byKey(const Key('HomePageIconButtonReport'));
      await tester.tap(reportPageButtonFinder);
      await tester.pumpAndSettle();
      // await Future.delayed(const Duration(milliseconds: 2000));
    },
  );
}
