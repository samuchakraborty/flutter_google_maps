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
    print(id);
    return id;
  }

  Future<List<StoreData>?> getAllStoreDataById() async {
    var dbClient = await db;

    var result =
        await dbClient.query(USER_STORE_TABLE);
    print(result);

    List<StoreData>? list = result.isNotEmpty
        ? result.map((c) => StoreData.fromMap(c)).toList()
        : null;

    return list;
  }

  Future<List<StoreData>> getAllUser() async {
    var dbClient = await db;
    List<Map<String, dynamic>> mapss = await dbClient.query(USER_STORE_TABLE,
        columns: [
          STORE_ID,
          STORE_ADDRESS_FROM_MAP,
          STORE_ADDRESS_TITLE,
          STORE_FLAT_NO
        ]);
    return List.generate(mapss.length, (i) {
      return StoreData(
          id: mapss[i]['id'],
          addressTitle: mapss[i]['address_title'],
          addressFromMap: mapss[i]['address_from_map'],
          flatNo: mapss[i]['flat_no']);
    });

    // return user;
  }

  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(USER_TABLE, where: '$ID = ?', whereArgs: [id]);
  // }

  // Future<int> update(User employee) async {
  //   var dbClient = await db;
  //   return await dbClient.update(USER_TABLE, employee.toMap(),
  //       where: '$ID = ?', whereArgs: [employee.id]);
  // }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
