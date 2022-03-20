import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseUtil {
  DatabaseUtil._();

  static final instance = DatabaseUtil._();

  Future<String> getDBPath() async {
    final dbPath = await getDatabasesPath();
    return path.join(dbPath, 'parking.db');
  }
}
