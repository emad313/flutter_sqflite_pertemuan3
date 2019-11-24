import 'package:flutter_news/model/Bookmark_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "flutter_news.db");
    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    //Run Migration according database versions
  }
  void _onCreate(Database db, int version) async {
    var sqlCreateTable = '''CREATE TABLE bookmark(
      id_berita TEXT,
      judul_berita TEXT,
      isi_berita TEXT,
      gambar_berita TEXT,
      nama_kategori TEXT,
      nama_wartawan TEXT,
      tanggal_berita TEXT
    )''';
    await db.execute(sqlCreateTable);
    print("Table Bookmark Has Been Created");
  }

  // Future newBookmark(Bookmark newBookmark) async {
  //   final db = await database;
  //   var res = await db.rawInsert(
  //       "INSERT INTO tb_bookmark (id_berita,judul_berita,isi_berita,nama_kategori,nama_wartawan,tanggal_berita)VALUES(\'${newBookmark.idBerita}\',\'${newBookmark.judulBerita}\',\'${newBookmark.isiBerita}\',\'${newBookmark.namaKategori}\',\'${newBookmark.namaWartawan}\',\'${newBookmark.tanggalBerita}\')");
  //   print("Print :  $res");
  //   return res;
  // }

  Future addBookmark(Bookmark newBookmark) async {
    var db = await database;
    int res = await db.insert("bookmark", newBookmark.toJson());
    return res;
  }

  Future removeBookmarkById(int idBerita) async {
    var db = await database;
    int res = await db
        .delete("bookmark", where: "id_berita = ?", whereArgs: [idBerita]);
    return res;
  }

  Future removeAllBookmark() async {
    var db = await database;
    int res = await db.delete("bookmark");
    return res;
  }

  Future<List<Bookmark>> getAllBookmark() async {
    final db = await database;
    var res = await db.query('bookmark');
    // List<Bookmark> list = res.isNotEmpty
    //     ? res.map((json) => Bookmark.fromJson(json)).toList()
    //     : [];
    List<Bookmark> list = res.map((json) => Bookmark.fromJson(json)).toList();
    return list;
  }
}
