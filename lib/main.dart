import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/parking_config_dao_impl.dart';
import 'package:parking/data/db/drift/parking_lots_dao_impl.dart';
import 'package:parking/pages/config/presentation/bloc/config_bloc.dart';
import 'package:parking/pages/parking_home_page.dart';
import 'package:parking/repositories/parking_config_repository.dart';
import 'package:parking/repositories/parking_lots_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  // final dbPath = await DatabaseUtil.instance.getDBPath();
  final _database = Database.instance;
  final parkingConfigDAO = ParkingConfigDaoImpl(
    _database,
  );
  runApp(
    Container(
      color: Colors.white,
      child: MultiProvider(
        providers: [
          BlocProvider<ConfigBloc>(
            create: (context) => ConfigBloc(
              parkingConfigRepository: ParkingConfigRepository(
                parkingConfigDAO: parkingConfigDAO,
              ),
            )..add(IsAlreadyConfigured()),
          ),
          RepositoryProvider<ParkingConfigRepository>(
            create: (context) => ParkingConfigRepository(
              parkingConfigDAO: parkingConfigDAO,
            ),
          ),
          RepositoryProvider<ParkingLotsRepository>(
            create: (context) => ParkingLotsRepository(
              parkingLotsDAO: ParkingLotsDaoImpl(
                _database,
              ),
            ),
          ),
        ],
        child: const ParkingHomePage(),
      ),
    ),
  );
}
