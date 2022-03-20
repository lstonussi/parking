import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_dao.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/tables/parking_config.dart' as table;
import 'package:parking/domain/models/parking_config.dart';

part 'parking_config_impl.g.dart';

@DriftAccessor(tables: [table.ParkingConfig])
class ParkingConfigImpl extends DatabaseAccessor<Database>
    with _$ParkingConfigImplMixin
    implements ParkingConfigDAO {
  ParkingConfigImpl(Database attachedDatabase) : super(attachedDatabase);

  @override
  Future<ParkingConfig> getConfig() async {
    try {
      final result = await (select(parkingConfig)..limit(1)).getSingle();
      return ParkingConfig(
          id: result.id,
          name: result.name,
          spaceQuantity: result.spaceQuantity);
    } on SqliteException {
      throw SelectException();
    } catch (e) {
      throw DartException(message: e.toString());
    }
  }

  @override
  Future insert(ParkingConfig parking) {
    // TODO: implement insert
    throw UnimplementedError();
  }
}
