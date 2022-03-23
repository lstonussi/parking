import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:parking/commons/error/exception.dart';
import 'package:parking/data/db/dao/parking_space_dao.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/tables/parking_space.dart' as table;
import 'package:parking/domain/models/parking_space_model.dart';
part 'parking_space_dao_impl.g.dart';

@DriftAccessor(tables: [table.ParkingSpace])
class ParkingSpaceDaoImpl extends DatabaseAccessor<Database>
    with _$ParkingSpaceDaoImplMixin
    implements ParkingSpaceDAO {
  ParkingSpaceDaoImpl(Database attachedDatabase) : super(attachedDatabase);

  @override
  Future<List<ParkingSpaceModel>> getAll() async {
    try {
      final nList = await (select(parkingSpace)
            ..orderBy(
              [
                (t) => OrderingTerm(
                      expression: t.id,
                      mode: OrderingMode.asc,
                    ),
              ],
            ))
          .get();

      final itemList = <ParkingSpaceModel>[];

      for (final n in nList) {
        itemList.add(
          ParkingSpaceModel(
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
  Future<int> insert(ParkingSpaceModel parkingSpaceModel) async {
    try {
      return await into(parkingSpace).insertOnConflictUpdate(
        ParkingSpaceCompanion.insert(
          plate: parkingSpaceModel.plate,
          modelCar: parkingSpaceModel.modelCar,
          spaceParkingCode: parkingSpaceModel.spaceParkingCode,
          entryDateTime: parkingSpaceModel.entryDateTime,
          departureDateTime: Value(parkingSpaceModel.departureDateTime),
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
      return await delete(parkingSpace).go();
    } on SqliteException {
      throw DeleteException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }

  @override
  Future<int> updateDate(ParkingSpaceModel parkingSpaceModel) async {
    try {
      return await customUpdate(
        'UPDATE parking_space SET departure_date_time = ? WHERE id = ?',
        updates: {
          parkingSpace,
        },
        variables: [
          Variable(parkingSpaceModel.departureDateTime),
          Variable(parkingSpaceModel.id),
        ],
        updateKind: UpdateKind.update,
      );
    } on SqliteException {
      throw UpdateException();
    } catch (e) {
      throw GenericException(message: e.toString());
    }
  }
}
