import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/data/db/dao/parking_space_dao.dart';
import 'package:parking/domain/models/parking_space_model.dart';
import 'package:parking/pages/home/domain/repositories/parking_space_repository.dart';

class ParkingSpaceRepositoryImpl implements ParkingSpaceRepository {
  ParkingSpaceRepositoryImpl({
    required this.parkingSpaceDAO,
  });
  final ParkingSpaceDAO parkingSpaceDAO;

  @override
  Future<Either<Failure, int>> insert(
      {required ParkingSpaceModel parkingSpaceModel}) async {
    try {
      final result =
          await parkingSpaceDAO.insert(parkingSpaceModel: parkingSpaceModel);
      return Right(result);
    } on InsertException {
      return Left(InsertDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateDate({
    required int id,
    required DateTime departureTime,
  }) async {
    try {
      final result = await parkingSpaceDAO.updateDate(
          id: id, departureTime: departureTime);
      return Right(result);
    } on UpdateException {
      return Left(UpdateDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
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

  @override
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
