import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/bloc/parking_bloc.dart';
import 'package:parking/pages/config/presentation/pages/config_page.dart';
import 'package:parking/pages/home/presentation/pages/home_page.dart';

class HomeOrConfig extends StatefulWidget {
  const HomeOrConfig({Key? key}) : super(key: key);

  @override
  State<HomeOrConfig> createState() => _HomeOrConfig();
}

bool isFirstAcess = false;

class _HomeOrConfig extends State<HomeOrConfig> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingBloc, ParkingState>(
      builder: ((context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NotConfigured) {
          return const ConfigPage();
        } else if (state is AlreadyConfigured || state is Saved) {
          return const HomePage();
        } else if (state is SaveError) {
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
      }),
    );
  }
}
