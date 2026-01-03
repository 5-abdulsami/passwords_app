import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/password_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('passwords.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE passwords ( 
  id $idType, 
  title $textType,
  username $textType,
  password $textType,
  created_at $textType
  )
''');
  }

  Future<int> create(Password password) async {
    final db = await instance.database;
    return await db.insert('passwords', password.toMap());
  }

  Future<Password> readPassword(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'passwords',
      columns: ['id', 'title', 'username', 'password', 'created_at'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Password.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Password>> readAllPasswords() async {
    final db = await instance.database;
    final result = await db.query('passwords', orderBy: 'created_at DESC');
    return result.map((json) => Password.fromMap(json)).toList();
  }

  Future<int> update(Password password) async {
    final db = await instance.database;

    return db.update(
      'passwords',
      password.toMap(),
      where: 'id = ?',
      whereArgs: [password.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'passwords',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
