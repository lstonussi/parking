import 'package:parking/domain/models/parking_lots.dart';

int verifyParkingSpace(
    {required List<ParkingLots> parkingLots, required int index}) {
  int spaceParkingCode = -1;
  if ((parkingLots.any(
    (element) {
      if (element.spaceParkingCode == index + 1) {
        spaceParkingCode = element.id!;
      }
      return element.spaceParkingCode == index + 1;
    },
  ))) {
    return spaceParkingCode;
  }
  return spaceParkingCode;
}
