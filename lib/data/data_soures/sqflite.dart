import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteClientApp {
  Database? _database;

  Future<Database> get _getDataBase async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'to_do.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todolist(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    selected INTEGER NOT NULL
    );
    ''');
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await _getDataBase;
    const sql = '''
    SELECT *
    FROM todolist;
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, dynamic>>> createTask(String text) async {
    final db = await _getDataBase;
    final sqlCreate = '''
    INSERT INTO todolist (name, selected) 
    VALUES ('$text', 0);
    ''';
    final int idRow = await db.rawInsert(sqlCreate);
    final sqlQuery = '''
    SELECT *
    FROM todolist
    WHERE id = $idRow
    ''';
    return await db.rawQuery(sqlQuery);
  }

  Future<int> deleteTask(int id) async {
    final db = await _getDataBase;
    final sql = '''
    DELETE FROM todolist
    WHERE id = $id;
    ''';
    return await db.rawDelete(sql);
  }

  Future<List<Map<String, dynamic>>> updateTask(int id, int select) async {
    final db = await _getDataBase;
    const sqlUpdate = '''
    UPDATE todolist
    SET selected = ?
    WHERE id = ?;
    ''';
    await db.rawUpdate(sqlUpdate, [select, id]);
    final sqlQuery = '''
    SELECT *
    FROM todolist
    WHERE id = $id
    ''';
    return await db.rawQuery(sqlQuery);
  }
}
