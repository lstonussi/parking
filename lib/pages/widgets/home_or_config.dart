import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/data/db/drift/parking_space_dao_impl.dart';
import 'package:parking/pages/config/presentation/bloc/config_bloc.dart';
import 'package:parking/pages/config/presentation/bloc/config_state.dart';
import 'package:parking/pages/config/presentation/pages/config_page.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart' as homebloc;
import 'package:parking/pages/home/presentation/pages/home_page.dart';
import 'package:parking/repositories/parking_space_repository.dart';

class HomeOrConfig extends StatelessWidget {
  const HomeOrConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotConfigured) {
          return const ConfigPage();
        } else if (state is AlreadyConfigured) {
          return BlocProvider<homebloc.HomeBloc>(
            create: (context) => homebloc.HomeBloc(
              parkingSpaceRepository: ParkingSpaceRepository(
                parkingSpaceDAO: ParkingSpaceDaoImpl(Database.instance),
              ),
            )..add(homebloc.RefreshList()),
            child: HomePage(
              name: state.name,
              quantitySpace: state.quantitySpace,
            ),
          );
        } else if (state is Saved) {
        } else if (state is SaveError || state is Error) {
          const Material(
            child: Center(
              child: Text('Error'),
            ),
          );
        }
        return const Material(
          child: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
