import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_lots_dao.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/tables/parking_lots.dart' as table;
import 'package:parking/domain/models/parking_lots.dart';
part 'parking_lots_dao_impl.g.dart';

@DriftAccessor(tables: [table.ParkingLots])
class ParkingLotsDaoImpl extends DatabaseAccessor<Database>
    with _$ParkingLotsDaoImplMixin
    implements ParkingLotsDAO {
  ParkingLotsDaoImpl(Database attachedDatabase) : super(attachedDatabase);

  @override
  Future<List<ParkingLots>> getAll() async {
    try {
      final nList = await (select(parkingLots)
            ..orderBy(
              [
                (t) => OrderingTerm(
                      expression: t.id,
                      mode: OrderingMode.asc,
                    ),
              ],
            ))
          .get();

      final itemList = <ParkingLots>[];

      for (final n in nList) {
        itemList.add(
          ParkingLots(
            id: n.id,
            plate: n.plate,
            modelCar: n.modelCar,
            spaceParkingCode: n.spaceParkingCode,
            entryDateTime: n.entryDateTime,
            departureDateTime: n.departureDateTime,
          ),
        );
      }
      return itemList;
    } on SqliteException {
      throw SelectException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<int> insert(ParkingLots parkingLot) async {
    try {
      return await into(parkingLots).insertOnConflictUpdate(
        ParkingLotsCompanion.insert(
          plate: parkingLot.plate,
          modelCar: parkingLot.modelCar,
          spaceParkingCode: parkingLot.spaceParkingCode,
          entryDateTime: parkingLot.entryDateTime,
          departureDateTime: Value(parkingLot.departureDateTime),
        ),
      );
    } on SqliteException {
      throw InsertException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<int> deleteAll() async {
    try {
      return await delete(parkingLots).go();
    } on SqliteException {
      throw DeleteException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }
}
