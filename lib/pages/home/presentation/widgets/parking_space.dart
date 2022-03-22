import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/domain/models/parking_lots.dart';

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
    return Container(
      child: Text('${index + 1}'),
      color: parkingLots.any((element) => element.spaceParkingCode == index + 1)
          ? Colors.red
          : Colors.green,
    );
  }
}

// Text('Vaga ${index + 1}'),
//             Text('Placa: ${parkingLots[index].plate}'),
//             Text('Marca: ${parkingLots[index].modelCar}'),
//             Text('Entrada: ${dateFormat.format(
//               parkingLots[index].entryDateTime,
//             )}'),
