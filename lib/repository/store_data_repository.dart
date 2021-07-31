import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_google_maps_task/model/store_data_model.dart';

class DataRepo extends ChangeNotifier {
  List<StoreData> _dataStore = [];


   UnmodifiableListView<StoreData> get dataRe =>
       UnmodifiableListView(_dataStore);
//List<StoreData> get dataRe => _dataStore;

  void add(StoreData dataStore) {
    _dataStore.add(dataStore);

    notifyListeners();
  }


}
