import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/domain/models/parking_space_model.dart';

abstract class ParkingSpaceRepository {
  Future<Either<Failure, int>> insert(
      {required ParkingSpaceModel parkingSpaceModel});

  Future<Either<Failure, int>> updateDate(
      {required ParkingSpaceModel parkingSpaceModel});

  Future<Either<Failure, List<ParkingSpaceModel>>> getAll();

  Future<Either<Failure, int>> deleteAll();
}
