import 'package:parking/domain/models/parking_config.dart';

abstract class ParkingConfigDAO {
  Future<int> insert(ParkingConfig parking);

  Future<ParkingConfig> getConfig();
}
