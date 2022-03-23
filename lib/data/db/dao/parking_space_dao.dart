import 'package:parking/domain/models/parking_space_model.dart';

abstract class ParkingSpaceDAO {
  Future<int> insert(ParkingSpaceModel parkingSpaceModel);

  Future<int> updateDate(ParkingSpaceModel parkingSpaceModel);

  Future<List<ParkingSpaceModel>> getAll();

  Future<int> deleteAll();
}
