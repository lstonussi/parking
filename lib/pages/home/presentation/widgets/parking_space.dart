import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_lots.dart';

DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

class ParkingSpace extends StatelessWidget {
  const ParkingSpace({
    Key? key,
    required this.index,
    this.color = Colors.red,
    // required this.parkingLots,
  }) : super(key: key);

  final int index;
  final Color color;
  // final List<ParkingLots> parkingLots;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$index'),
      color: color,
    );
    // return Container(
    //   color: parkingLots[index].spaceParkingCode == index
    //       ? Colors.red
    //       : Colors.green,
    //   width: 10,
    //   height: 10,
    // );
  }
}

// Text('Vaga ${index + 1}'),
//             Text('Placa: ${parkingLots[index].plate}'),
//             Text('Marca: ${parkingLots[index].modelCar}'),
//             Text('Entrada: ${dateFormat.format(
//               parkingLots[index].entryDateTime,
//             )}'),
