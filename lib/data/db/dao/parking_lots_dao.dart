import 'package:parking/domain/models/parking_lots.dart';

abstract class ParkingLotsDAO {
  Future<int> insert(ParkingLots parkingLots);

  Future<List<ParkingLots>> getAll();

  Future<int> deleteAll();
}
