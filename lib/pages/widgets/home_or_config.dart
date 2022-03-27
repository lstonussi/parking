import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/pages/config/presentation/bloc/config_bloc.dart';
import 'package:parking/pages/config/presentation/bloc/config_state.dart';
import 'package:parking/pages/config/presentation/pages/config_page.dart';
import 'package:parking/pages/home/domain/repositories/parking_space_repository.dart';
import 'package:parking/pages/home/presentation/bloc/_bloc.dart' as homebloc;
import 'package:parking/pages/home/presentation/pages/home_page.dart';

class HomeOrConfig extends StatelessWidget {
  const HomeOrConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<ConfigBloc, ConfigState>(
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
                parkingSpaceRepository: context.read<ParkingSpaceRepository>(),
              )..add(const homebloc.RefreshList()),
              child: HomePage(
                name: state.name,
                quantitySpace: state.quantitySpace,
              ),
            );
          } else if (state is SaveError || state is Error) {
            const Material(
              child: Center(
                child: Text('Error'),
              ),
            );
          }
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
