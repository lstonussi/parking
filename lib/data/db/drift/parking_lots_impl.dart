import 'package:drift/drift.dart';
import 'package:parking/data/db/dao/parking_lots_dao.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/tables/parking_lots.dart' as table;
import 'package:parking/domain/models/parking_lots.dart';
part 'parking_lots_impl.g.dart';

@DriftAccessor(tables: [table.ParkingLots])
class ParkingLotsImpl extends DatabaseAccessor<Database>
    with _$ParkingLotsImplMixin
    implements ParkingLotsDAO {
  ParkingLotsImpl(Database attachedDatabase) : super(attachedDatabase);

  @override
  Future<List<ParkingLots>> getAll() async {
    final nList = await (select(parkingLots)
          ..orderBy(
            [
              (t) => OrderingTerm(
                    expression: t.entryDateTime,
                    mode: OrderingMode.desc,
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
  }

  @override
  Future insert(ParkingLots parkingLot) async {
    await into(parkingLots).insertOnConflictUpdate(
      ParkingLotsCompanion.insert(
        id: Value(parkingLot.id),
        plate: parkingLot.plate,
        modelCar: parkingLot.modelCar,
        spaceParkingCode: parkingLot.spaceParkingCode,
        entryDateTime: parkingLot.entryDateTime,
        departureDateTime: parkingLot.departureDateTime,
      ),
    );
  }

  @override
  Future deleteAll() async {
    return await delete(parkingLots).go();
  }
}
