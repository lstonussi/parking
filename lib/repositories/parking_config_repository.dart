import 'package:dartz/dartz.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/commons/error/failure.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/domain/models/parking_config.dart';

class ParkingConfigRepository {
  ParkingConfigRepository({
    required this.parkingConfigDAO,
  });
  final ParkingConfigDAO parkingConfigDAO;

  Future<Either<Failure, void>> insert(ParkingConfig parkingConfig) async {
    try {
      return await parkingConfigDAO.insert(parkingConfig);
    } on SelectException {
      return Left(InsertDataBaseFailure());
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

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
