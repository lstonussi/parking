import 'package:parking/domain/models/parking_space_model.dart';

abstract class ParkingSpaceDAO {
  Future<int> insert({required ParkingSpaceModel parkingSpaceModel});

  Future<int> updateDate({required int id, required DateTime departureTime});

  Future<List<ParkingSpaceModel>> getAll();

  Future<int> deleteAll();
}
