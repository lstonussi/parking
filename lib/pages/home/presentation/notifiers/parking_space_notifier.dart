import 'package:flutter/material.dart';
import 'package:parking/domain/models/parking_space_model.dart';

class ParkingSpaceNotifier extends ChangeNotifier {
  final List<ParkingSpaceModel> _parkingSpace = [];

  get list {
    return _parkingSpace;
  }

  void onListRecieve(List<ParkingSpaceModel> list) {
    if (list.isNotEmpty) {
      _parkingSpace.clear();
      _parkingSpace.addAll(list);
    }
  }

  int verifyParkingSpace({required int index}) {
    int spaceParkingCode = -1;
    if ((_parkingSpace.any(
      (element) {
        final result = ((element.spaceParkingCode == index + 1) &&
            (element.departureDateTime == null));

        if (result) {
          spaceParkingCode = element.id!;
        }
        return result;
      },
    ))) {
      return spaceParkingCode;
    }
    return spaceParkingCode;
  }
}
