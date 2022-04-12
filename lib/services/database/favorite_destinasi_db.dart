import 'dart:io';
import 'package:labtour/models/destinasi_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFavorite {
  static const _databaseName = 'FavoriteData.db';
  static const _databaseVersion = 1;

  // singleton
  DatabaseFavorite._();
  static final DatabaseFavorite instance = DatabaseFavorite._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${DestinasiModel.tblFavorite}(
      ${DestinasiModel.colId} INTEGER PRIMARY KEY,
      ${DestinasiModel.colName} TEXT NOT NULL,
      ${DestinasiModel.colImage} TEXT NOT NULL,
      ${DestinasiModel.colRating} TEXT NOT NULL,
      ${DestinasiModel.colWeekday} TEXT NOT NULL,
      ${DestinasiModel.colKategoriRisk} TEXT NOT NULL,
      ${DestinasiModel.colCity} TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertFavorite(DestinasiModel destinasi) async {
    Database db = await database;
    return await db.insert(DestinasiModel.tblFavorite, destinasi.toJson());
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await database;
    return await db.delete(DestinasiModel.tblFavorite,
        where: '${DestinasiModel.colId}=?', whereArgs: [id]);
  }

  Future<bool> isFavorite(int id) async {
    Database db = await database;
    List<Map> list = await db.rawQuery(
        'SELECT * FROM ${DestinasiModel.tblFavorite} WHERE ${DestinasiModel.colId} = $id');
    return list.length > 0 ? true : false;
  }

  Future<List<DestinasiModel>> fetchFavorite() async {
    Database db = await database;
    List<Map> destinasi = await db.query(DestinasiModel.tblFavorite);
    print("Destinasi Favorite");
    print(destinasi.length);
    print(destinasi);
    return destinasi.length == 0
        ? []
        : destinasi.map((e) => DestinasiModel.fromJson(e)).toList();
  }
}
