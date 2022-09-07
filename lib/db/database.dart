import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'card.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'CardDB.db'),
      onCreate: (database, version) async {
        await database.execute('''
CREATE TABLE card( 
  id INTEGER PRIMARY KEY, 
  nickName TEXT NOT NULL,
  billingDate INTEGER NOT NULL,
  currentAmount DOUBLE,
  cashLimit DOUBLE
  )
''');
      },
      version: 2,
    );
  }

  Future<void> insertCard(CardDetail card) async {
    final db = await initializeDB();
    // final id = await db.rawInsert('INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    int id = await db.insert(
      'card',
      card.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CardDetail>> searchCard() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('card');
    return queryResult.map((e) => CardDetail.fromMap(e)).toList();
  }

  Future<void> deleteCard(String nickName) async {
    final db = await initializeDB();
    int i = await db.delete(
      'card',
      where: 'nickName = ?',
      whereArgs: [nickName],
    );
  }
  Future<int> updateAmount(CardDetail card) async {
    final db = await initializeDB();
    return await db.update('card', card.toMap(),
        where: 'nickName = ?', whereArgs: [card.nickName]);
  }

}
