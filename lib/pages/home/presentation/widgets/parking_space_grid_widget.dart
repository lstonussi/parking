import 'package:flutter/material.dart';
import 'package:parking/pages/home/presentation/widgets/parking_space_widget.dart';
import 'package:parking/values/app_texts.dart';

class ParkingSpaceGrid extends StatelessWidget {
  const ParkingSpaceGrid({
    Key? key,
    required this.listParkingSpace,
    required this.avaibleLots,
  }) : super(key: key);

  final List<ParkingSpace> listParkingSpace;
  final int avaibleLots;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${AppTexts.parkingSpaceAvaible} ${(avaibleLots).toString()}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            childAspectRatio: .8,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: listParkingSpace,
          ),
        ),
      ],
    );
  }
}
