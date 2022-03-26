import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
class DBhelper{
  static Future<sql.Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(join(dbPath,'places.db'), onCreate: (db,version){
      return db.execute("CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAl, address TEXT)");
    },version: 1);
  }

  static Future<void> insert(String table,Map<String, dynamic> data) async{
    final db = await DBhelper.database();
    db.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async{
    final db = await DBhelper.database();
    return db.query(table);
  }
}