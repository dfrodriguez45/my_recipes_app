import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Recipe (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        imagePath TEXT,
        totalTime INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Ingredient (
        id TEXT PRIMARY KEY,
        recipeId TEXT,
        name TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit TEXT NOT NULL,
        FOREIGN KEY(recipeId) REFERENCES Recipe(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Step (
        id TEXT PRIMARY KEY,
        recipeId TEXT,
        "order" INTEGER NOT NULL,
        description TEXT NOT NULL,
        time INTEGER NOT NULL,
        FOREIGN KEY(recipeId) REFERENCES Recipe(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    await _database?.close();
  }
}
