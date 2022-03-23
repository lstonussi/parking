import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/data/db/dao/parking_space_dao.dart';
import 'package:parking/domain/models/parking_space_model.dart';

class ParkingSpaceRepository {
  ParkingSpaceRepository({
    required this.parkingSpaceDAO,
  });
  final ParkingSpaceDAO parkingSpaceDAO;

  Future<Either<Failure, int>> insert(ParkingSpaceModel parkingConfig) async {
    try {
      final result = await parkingSpaceDAO.insert(parkingConfig);
      return Right(result);
    } on InsertException {
      return Left(InsertDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> updateDate(
      ParkingSpaceModel parkingSpaceModel) async {
    try {
      final result = await parkingSpaceDAO.updateDate(parkingSpaceModel);
      return Right(result);
    } on UpdateException {
      return Left(UpdateDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<ParkingSpaceModel>>> getAll() async {
    try {
      final result = await parkingSpaceDAO.getAll();
      return Right(result);
    } on SelectDataBaseFailure {
      return Left(SelectDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteAll() async {
    try {
      final result = await parkingSpaceDAO.deleteAll();
      return Right(result);
    } on DeleteException {
      return Left(DeleteDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
