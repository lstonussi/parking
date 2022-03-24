import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/domain/models/parking_config.dart';
import 'package:parking/pages/config/domain/repositories/parking_config_repository.dart';

class ParkingConfigRepositoryImpl implements ParkingConfigRepository {
  ParkingConfigRepositoryImpl({
    required this.parkingConfigDAO,
  });
  final ParkingConfigDAO parkingConfigDAO;
  @override
  Future<Either<Failure, int>> insert(
      {required String name, required int quantitySpace}) async {
    try {
      final result = await parkingConfigDAO.insert(
        name: name,
        quantitySpace: quantitySpace,
      );
      return Right(result);
    } on InsertException {
      return Left(InsertDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ParkingConfig>> getConfig() async {
    try {
      final result = await parkingConfigDAO.getConfig();
      return Right(result);
    } on SelectException {
      return Left(SelectDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }
}
