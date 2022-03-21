import 'package:parking/domain/models/parking_config.dart';

abstract class ParkingConfigDAO {
  Future<int> insert({required String name, required int quantitySpace});

  Future<ParkingConfig> getConfig();
}
