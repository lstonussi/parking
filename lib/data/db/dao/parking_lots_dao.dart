import 'package:parking/domain/models/parking_lots.dart';

abstract class ParkingLotsDAO {
  Future insert(ParkingLots parkingLots);

  Future<List<ParkingLots>> getAll();

  Future deleteAll();
}
