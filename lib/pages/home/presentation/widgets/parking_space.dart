import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_lots.dart';

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
    return Container(
      child: Text('Vaga ${index + 1}'),
      color: parkingLots.isNotEmpty && parkingLots[index].id == index
          ? Colors.red
          : Colors.green,
      width: 10,
      height: 10,
    );
  }
}
