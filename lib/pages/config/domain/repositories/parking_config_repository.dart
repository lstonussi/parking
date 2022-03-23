import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/domain/models/parking_config.dart';

abstract class ParkingConfigRepository {
  Future<Either<Failure, int>> insert(
      {required String name, required int quantitySpace});

  Future<Either<Failure, ParkingConfig>> getConfig();
}
