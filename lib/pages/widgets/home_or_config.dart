import 'package:flutter/material.dart';
import 'package:parking/pages/initial_config/presentation/pages/initial_config.dart';
import 'package:parking/repositories/parking_config_repository.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getData();
    });
  }

  //Adicionar bloc
  Future<void> _getData() async {
    final parkingConfig = context.read<ParkingConfigRepository>();
    final resultOrFailure = await parkingConfig.getConfig();
    resultOrFailure.fold((error) => null, (parkingConfig) {
      setState(() {
        isFirstAcess = (parkingConfig.id ?? 0) == 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isFirstAcess
        ? const InitialConfig()
        : Container(
            color: Colors.red,
          );
  }
}
