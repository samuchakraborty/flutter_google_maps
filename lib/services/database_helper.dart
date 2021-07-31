import 'dart:async';
import 'dart:io' as io;

import 'package:flutter_google_maps_task/model/store_data_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  late Database _db;
  static const String USER_DB_NAME = 'user.db';

  //STORE DATA
  static const String USER_STORE_TABLE = 'storeData';
  static const String STORE_ID = 'id';
  static const String STORE_ADDRESS_TITLE = 'address_title';
  static const String STORE_ADDRESS_FROM_MAP = 'address_from_map';
  static const String STORE_FLAT_NO = 'flat_no';

  Future<Database> get db async {
    // if (_db != null) {
    //   return _db;
    // }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, USER_DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $USER_STORE_TABLE ($STORE_ID INTEGER PRIMARY KEY autoincrement, $STORE_ADDRESS_FROM_MAP TEXT,$STORE_FLAT_NO TEXT, $STORE_ADDRESS_TITLE TEXT)');
  }

  Future storeData(StoreData user) async {
    var dbClient = await db;
    int id = await dbClient.insert(USER_STORE_TABLE, user.toStore());
  //  print(id);
    return id;
  }

  Future<List<StoreData>?> getAllStoreData() async {
    var dbClient = await db;

    var result =
        await dbClient.query(USER_STORE_TABLE);
//    print(result);

    List<StoreData>? list = result.isNotEmpty
        ? result.map((c) => StoreData.fromMap(c)).toList()
        : null;

    return list;
  }



  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
