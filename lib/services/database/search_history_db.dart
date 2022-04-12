import 'dart:io';

import 'package:labtour/models/search_history_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSearchHistory {
  static const _databaseName = 'searchHistory.db';
  static const _databaseVersion = 1;

  DatabaseSearchHistory._();
  static final DatabaseSearchHistory instance = DatabaseSearchHistory._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    print("Database directory ${dataDirectory.path}");
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${SearchHistoryModel.tblHistory}(
      ${SearchHistoryModel.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${SearchHistoryModel.colTitle} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertHistory(String value) async {
    Database db = await database;
    return await db.insert(SearchHistoryModel.tblHistory, {'title': value});
  }

  Future<int> deleteHistory(int id) async {
    Database db = await database;
    return await db.delete(SearchHistoryModel.tblHistory,
        where: '${SearchHistoryModel.colId}=?', whereArgs: [id]);
  }

  Future<List<SearchHistoryModel>> fetchHistory() async {
    Database db = await database;
    List<Map> history = await db.rawQuery(
        'SELECT * FROM ${SearchHistoryModel.tblHistory} ORDER BY ${SearchHistoryModel.colId} DESC');

    print('history');
    print(history.length);
    print(history);
    return history.length == 0
        ? []
        : history.map((e) => SearchHistoryModel.fromJson(e)).toList();
  }
}
