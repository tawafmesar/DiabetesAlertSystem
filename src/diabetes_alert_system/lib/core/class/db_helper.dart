import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'diabetes_alert.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "medications" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "class" TEXT,
        "type" TEXT,
        "dosage" TEXT,
        "frequency" TEXT,
        "users_id" INTEGER,
        "medication_date_create" TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE "metrics" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "metric_type" TEXT NOT NULL,
        "value1" TEXT NOT NULL,
        "value2" TEXT,
        "user_id" INTEGER,
        "metric_timestamp" TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE "alarms" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "is_active" INTEGER,
        "is_ringing" INTEGER,
        "name_of_alarm" TEXT,
        "alarm_time_hour" INTEGER,
        "alarm_time_minute" INTEGER,
        "alarm_date" TEXT,
        "is_recurrent" INTEGER,
        "weekday_recurrence" TEXT,
        "challenge_mode" INTEGER,
        "users_id" INTEGER,
        "medications_id" INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE "activities" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "user_id" INTEGER,
        "category" TEXT,
        "activity_type" TEXT,
        "duration_hours" INTEGER,
        "duration_minutes" INTEGER,
        "duration_seconds" INTEGER,
        "user_weight" REAL,
        "calories_burned" REAL,
        "activity_date" TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    print("onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  // Helper for parameterized queries
  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?>? arguments]) async {
    Database? mydb = await db;
    return await mydb!.rawQuery(sql, arguments);
  }

  Future<int> rawInsert(String sql, [List<Object?>? arguments]) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql, arguments);
  }

  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql, arguments);
  }

  Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql, arguments);
  }
}
