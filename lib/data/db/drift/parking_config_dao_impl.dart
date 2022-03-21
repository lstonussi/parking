import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/tables/parking_config.dart' as table;
import 'package:parking/domain/models/parking_config.dart';

part 'parking_config_dao_impl.g.dart';

@DriftAccessor(tables: [table.ParkingConfig])
class ParkingConfigDaoImpl extends DatabaseAccessor<Database>
    with _$ParkingConfigDaoImplMixin
    implements ParkingConfigDAO {
  ParkingConfigDaoImpl(Database attachedDatabase) : super(attachedDatabase);

  @override
  Future<ParkingConfig> getConfig() async {
    try {
      final result = await (select(parkingConfig)).getSingleOrNull();
      return ParkingConfig(
          id: result?.id,
          name: result?.name,
          spaceQuantity: result?.spaceQuantity);
    } on SqliteException {
      throw SelectException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<int> insert({required String name, required int quantitySpace}) async {
    try {
      return await into(parkingConfig).insertOnConflictUpdate(
        ParkingConfigCompanion.insert(
          name: name,
          spaceQuantity: quantitySpace,
        ),
      );
    } on SqliteException {
      throw InsertException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }
}
