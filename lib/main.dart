import 'package:flutter/material.dart';
import 'package:parking/data/db/drift/drift_database.dart';
import 'package:parking/pages/parking_home_page.dart';
import 'package:parking/utils/database_util.dart';

void main() async {
  final dbPath = await DatabaseUtil.instance.getDBPath();
  final _database = Database.instance;
  runApp(
    Container(
      color: Colors.white,
      // child: MultiProvider(
      // providers: const [],
      child: const ParkingHomePage(),
      // ),
    ),
  );
}
