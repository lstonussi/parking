import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/parking_config_dao_impl.dart';
import 'package:parking/data/db/drift/parking_space_dao_impl.dart';
import 'package:parking/pages/config/presentation/bloc/config_bloc.dart';
import 'package:parking/pages/widgets/home_or_config.dart';
import 'package:parking/pages/config/data/repositories/parking_config_repository_impl.dart';
import 'package:parking/pages/home/data/repositories/parking_space_repository_impl.dart';
import 'package:provider/provider.dart';

import 'pages/config/domain/repositories/parking_config_repository.dart';
import 'pages/config/presentation/bloc/config_event.dart';
import 'pages/home/domain/repositories/parking_space_repository.dart';
import 'pages/home/presentation/notifiers/parking_space_notifier.dart';

void main() async {
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
              parkingConfigRepository: ParkingConfigRepositoryImpl(
                parkingConfigDAO: parkingConfigDAO,
              ),
            )..add(IsAlreadyConfigured()),
          ),
          RepositoryProvider<ParkingConfigRepository>(
            create: (context) => ParkingConfigRepositoryImpl(
              parkingConfigDAO: parkingConfigDAO,
            ),
          ),
          RepositoryProvider<ParkingSpaceRepository>(
            create: (context) => ParkingSpaceRepositoryImpl(
              parkingSpaceDAO: ParkingSpaceDaoImpl(
                _database,
              ),
            ),
          ),
          ChangeNotifierProvider<ParkingSpaceNotifier>(
            create: (_) => ParkingSpaceNotifier(),
          ),
        ],
        child: const HomeOrConfig(),
      ),
    ),
  );
}
