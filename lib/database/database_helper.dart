import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final _dbName = 'myDatabase.db'; // Extension important
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final _columnId = '_id';
  static final _columnName = 'name';

  // Make it Singleton using Private Constructor:
  DatabaseHelper._privateConstructor();
  // Database instance:
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Initialize DB
  static Database _database;
  Future<Database> get database async {
    if(_database != null){
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // Where Database file is be located:
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    // Open database file:
    return await openDatabase(path, version: _dbVersion, onCreate: _createTable);
  }

  Future _createTable(Database db, int version){
    return db.execute(
      '''
      CREATE TABLE $_tableName(
        $_columnId INTEGER PRIMARY KEY,
        $_columnName TEXT NOT NULL
      )
      '''
    );
  }

  // This is a Map
  //  {
  //    "_id": 22,
  //    "name": "Mafe"
  //  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // We're returning the auto-generated primary key
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_columnId];
    return await db.update(
      _tableName,
      row,
      where: '$_columnId = ?',
      whereArgs: [id]
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id]
    );
  }
}