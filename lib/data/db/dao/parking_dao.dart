import 'package:parking/domain/models/parking_config.dart';

abstract class ParkingConfigDAO {
  Future insert(ParkingConfig parking);

  Future<ParkingConfig> getConfig();
}
