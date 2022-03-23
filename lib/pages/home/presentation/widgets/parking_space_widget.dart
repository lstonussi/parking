import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/notifiers/parking_space_notifier.dart';
import 'package:parking/pages/home/utils/departure_bottom_sheet.dart';
import 'package:parking/pages/home/utils/entry_bottom_sheet.dart';
import 'package:provider/provider.dart';

DateFormat dateFormatDate = DateFormat('dd/MM/yy');
DateFormat dateFormatTime = DateFormat('HH:mm:ss');

class ParkingSpace extends StatelessWidget {
  const ParkingSpace({
    Key? key,
    required this.index,
    required this.parkingSpace,
  }) : super(key: key);

  final int index;
  final List<ParkingSpaceModel> parkingSpace;

  @override
  Widget build(BuildContext context) {
    final finalIndex =
        context.read<ParkingSpaceNotifier>().verifyParkingSpace(index: index);
    final hasCar = (finalIndex != -1);
    return GestureDetector(
      onTap: () {
        if (finalIndex >= 0) {
          showDepartureBottomSheet(
              context: context, parkingSpace: parkingSpace[finalIndex - 1]);
        } else {
          showEntryBottomSheet(context: context, parkingSpace: index + 1);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: hasCar ? Colors.red : Colors.green,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: hasCar
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      parkingSpace[finalIndex - 1].plate,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      parkingSpace[finalIndex - 1].modelCar,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dateFormatDate
                          .format(parkingSpace[finalIndex - 1].entryDateTime),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      dateFormatTime
                          .format(parkingSpace[finalIndex - 1].entryDateTime),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      parkingSpace[finalIndex - 1].departureDateTime != null
                          ? dateFormatTime.format(
                              parkingSpace[finalIndex - 1].departureDateTime!)
                          : '',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
      ),
    );
  }
}
