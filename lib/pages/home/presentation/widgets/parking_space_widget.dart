import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_lots.dart';
import 'package:parking/pages/home/utils/entry_bottom_sheet.dart';
import 'package:parking/pages/home/utils/verify_parking_space.dart';

DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

class ParkingSpace extends StatelessWidget {
  const ParkingSpace({
    Key? key,
    required this.index,
    required this.parkingLots,
  }) : super(key: key);

  final int index;
  final List<ParkingLots> parkingLots;

  @override
  Widget build(BuildContext context) {
    final hasCar =
        (parkingLots.any((element) => element.spaceParkingCode == index + 1));
    final finalIndex =
        verifyParkingSpace(parkingLots: parkingLots, index: index);
    return GestureDetector(
      onTap: () {
        if (finalIndex >= 0) {
          print(parkingLots[finalIndex - 1]);
        } else {
          showEntryBottomSheet(context: context, parkingSpace: index + 1);
        }
      },
      child: Container(
        child: hasCar
            ? Column(
                children: [
                  Text('${index + 1}'),
                  Text(parkingLots[finalIndex - 1].plate),
                  Text(parkingLots[finalIndex - 1].modelCar),
                  Text(dateFormat
                      .format(parkingLots[finalIndex - 1].entryDateTime)),
                ],
              )
            : Text('${index + 1}'),
        color: hasCar ? Colors.red : Colors.green,
      ),
    );
  }
}
