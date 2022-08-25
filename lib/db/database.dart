import 'dart:ffi';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();
NotesDatabase();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, filePath),
        version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE notes ( 
  _id INTEGER PRIMARY KEY AUTOINCREMENT, 
  nickName TEXT NOT NULL,
  billingDate INTEGER NOT NULL,
  currentAmount DOUBLE,
  cashLimit DOUBLE
  )
''');
  }

  Future insertDb(int idNum,String nickName,int billingDate,Double currentAmount,Double cashLimit) async {
    final db = await instance.database;
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
    final id = await db.insert('notes', toJson(idNum,nickName,billingDate,currentAmount,cashLimit));
  }

  Map<String, Object?> toJson(int id,String nickName,int billingDate,Double currentAmount,Double cashLimit) => {
        '_id': id,
        'nickName': nickName,
        'billingDate': billingDate,
        'currentAmount': currentAmount,
        'cashLimit': cashLimit,
      };
  Future<List> searchDb() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> queryResult = await db.query('notes');
    return queryResult.toList();
  }

  Future<void> deleteInstance(int id) async {
    final db = await instance.database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
