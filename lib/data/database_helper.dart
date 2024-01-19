import 'dart:io';
import 'package:example_sqflite_app/model/kategori_model.dart';
import 'package:example_sqflite_app/model/not_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static DataBaseHelper? _dataBaseHelper;
  static Database? _dataBase;

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._internal();
      return _dataBaseHelper!;
    } else {
      return _dataBaseHelper!;
    }
  }

  DataBaseHelper._internal();

  Future<Database> _getDataBase() async {
    if (_dataBase == null) {
      _dataBase = await _initializeDatabase();
      return _dataBase!;
    } else {
      return _dataBase!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "notlar.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(url.join("assets", "notlar.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

// open the database
    return await openDatabase(path, readOnly: false);
  }

/**Kategori */
  Future<List<Map<String, dynamic>>> kategorileriGetir() async {
    var db = await _getDataBase();
    var result = await db.query("kategori");
    return result;
  }

  Future<List<Kategori>> kategoriListesiniGetir() async {
    var kategorilerListesi = await kategorileriGetir();
    List<Kategori> kategoriList = [];
    for (var map in kategorilerListesi) {
      kategoriList.add(Kategori.fromMap(map));
    }
    return kategoriList;
  }

  Future<int> kategoriEkle(Kategori kategori) async {
    var db = await _getDataBase();
    var result = await db.insert("kategori", kategori.toMap());
    return result;
  }

  Future<int> kategoriGuncelle(Kategori kategori) async {
    var db = await _getDataBase();
    var result = await db.update("kategori", kategori.toMap(),
        where: "kategoriId = ? ", whereArgs: [kategori.kategoriId]);
    return result;
  }

  Future<int> kategoriSil(int kategoriId) async {
    var db = await _getDataBase();
    var result = await db
        .delete("kategori", where: "kategoriId = ? ", whereArgs: [kategoriId]);
    return result;
  }

/**not */

  Future<int> notEkle(Not not) async {
    var db = await _getDataBase();
    var result = await db.insert("not", not.toMap());
    return result;
  }

// orderby eklenen notunID değerine göre sıralamak için kullanılıyor. yani ilk eklenen not altta son ekleenen üstte gibi.
//çoklu tablolar kullanılırken tablolar birbirine bağımlı oluyor. yani bir   A tablosuNU çağırdığınızda B tablosuna bağımlı olduğu için B tablosunuda çağırman gerek. sql sorgusu     SELECT * FROM  "not" INNER JOIN kategori ON kategori.kategoriId ="not".kategoriId;
// önce not  tablosunu çağırıyor, sonra kategori taoblosuyla birleştiriyor,sonra da kategoriId değerini aynı tabloda getiriyor.
  Future<List<Map<String, dynamic>>> notlariGetir() async {
    var db = await _getDataBase();
    var result = await db.rawQuery(
        'SELECT * FROM  "not" INNER JOIN kategori ON kategori.kategoriId ="not".kategoriId  order by notId Desc');
    return result;
  }

//notları getirmek istediğimizde gelen notu bana map olarak veriyor. gelen mapi direk bir listeye ekleyip,kullanmak için bu fonksiyonu yazdım.
  Future<List<Not>> notListesiniGetir() async {
    var notlarListesi = await notlariGetir();
    List<Not> notList = [];
    for (var map in notlarListesi) {
      notList.add(Not.fromMap(map));
    }
    return notList;
  }

  Future<int> notGuncelle(Not not) async {
    var db = await _getDataBase();
    var result = await db
        .update("not", not.toMap(), where: "notId = ?", whereArgs: [not.notId]);
    return result;
  }

  Future<int> notSil(int notId) async {
    var db = await _getDataBase();
    var result = await db.delete("not", where: "notId = ?", whereArgs: [notId]);
    return result;
  }
}
