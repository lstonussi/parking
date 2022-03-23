import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/presentation/bloc/home_bloc.dart';
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
    required this.typeView,
  }) : super(key: key);

  final int index;
  final List<ParkingSpaceModel> parkingSpace;
  final TypeView typeView;
  @override
  Widget build(BuildContext context) {
    final isCompact = typeView == TypeView.compact;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vaga Nº: ${index + 1}',
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.headline6,
                    ),
                    isCompact
                        ? const SizedBox(height: 2)
                        : const SizedBox(height: 4),
                    Text(
                      parkingSpace[finalIndex - 1].plate,
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.headline6,
                    ),
                    isCompact
                        ? const SizedBox(height: 1)
                        : const SizedBox(height: 2),
                    Text(
                      parkingSpace[finalIndex - 1].modelCar,
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText1
                          : Theme.of(context).textTheme.headline6,
                    ),
                    isCompact
                        ? const SizedBox(height: 2)
                        : const SizedBox(height: 4),
                    Text(
                      dateFormatDate
                          .format(parkingSpace[finalIndex - 1].entryDateTime),
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.headline6,
                    ),
                    isCompact
                        ? const SizedBox(height: 1)
                        : const SizedBox(height: 2),
                    Text(
                      dateFormatTime
                          .format(parkingSpace[finalIndex - 1].entryDateTime),
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      parkingSpace[finalIndex - 1].departureDateTime != null
                          ? dateFormatTime.format(
                              parkingSpace[finalIndex - 1].departureDateTime!)
                          : '',
                      style: isCompact
                          ? Theme.of(context).textTheme.bodyText2
                          : Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  'Vaga Nº: ${index + 1}',
                  style: isCompact
                      ? Theme.of(context).textTheme.bodyText1
                      : Theme.of(context).textTheme.headline6,
                ),
              ),
      ),
    );
  }
}
