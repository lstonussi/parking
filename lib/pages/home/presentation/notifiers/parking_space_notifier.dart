import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_lots.dart';

class ParkingSpaceNotifier extends ChangeNotifier {
  final List<ParkingLots> _parkingLots = [];

  get list {
    return _parkingLots;
  }

  void onListRecieve(List<ParkingLots> list) {
    if (list.isNotEmpty) {
      _parkingLots.clear();
      _parkingLots.addAll(list);
    }
  }
}
