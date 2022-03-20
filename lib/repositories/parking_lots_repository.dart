import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/data/db/dao/parking_lots_dao.dart';
import 'package:parking/domain/models/parking_lots.dart';

class ParkingLotsRepository {
  ParkingLotsRepository({
    required this.parkingLotsDAO,
  });
  final ParkingLotsDAO parkingLotsDAO;

  Future<Either<Failure, int>> insert(ParkingLots parkingConfig) async {
    try {
      final result = await parkingLotsDAO.insert(parkingConfig);
      return Right(result);
    } on InsertException {
      return Left(InsertDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<ParkingLots>>> getAll() async {
    try {
      final result = await parkingLotsDAO.getAll();
      return Right(result);
    } on SelectDataBaseFailure {
      return Left(SelectDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteAll() async {
    try {
      final result = await parkingLotsDAO.deleteAll();
      return Right(result);
    } on DeleteException {
      return Left(DeleteDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
