import 'package:flutter/material.dart';
import 'package:parking/pages/widgets/home_or_config.dart';

class ParkingHomePage extends StatefulWidget {
  const ParkingHomePage({Key? key}) : super(key: key);

  @override
  State<ParkingHomePage> createState() => _ParkingState();
}

class _ParkingState extends State<ParkingHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeOrConfig(),
    );
  }
}
