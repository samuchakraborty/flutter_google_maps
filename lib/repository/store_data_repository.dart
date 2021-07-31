import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_google_maps_task/model/store_data_model.dart';
import 'package:flutter_google_maps_task/services/database_helper.dart';

class DataRepo extends ChangeNotifier {
  List<StoreData> _dataStore = [];

  UnmodifiableListView<StoreData> get dataRe =>
      UnmodifiableListView(_dataStore);

//List<StoreData> get dataRe => _dataStore;

  DataRepo() {
    fetchData();
  }

  fetchData() {
    Future<List<StoreData>?> listOfStoreData = DBHelper().getAllStoreData();

    listOfStoreData.then((value) {
      print(value.runtimeType);

      value!.forEach((element) {
        _dataStore.add(element);
      });

      notifyListeners();
    });
  }

  void add(StoreData dataStore) {
    _dataStore.add(dataStore);

    notifyListeners();
  }
}
