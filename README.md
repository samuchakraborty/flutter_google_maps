# Project Name

## Flutter Google Maps

### Table of Contents
  - [Description](#description)
  - [How To Use](#how-to-use)
  - [Demo](#demo)
  - [DataBase](#database)
  - [Google Map](#google-map)
  - [Flutter RiverPod](#flutter-riverpod)
  - [Project Images](#project-images)
  - [Uses Packages](#uses-packages)
  - [Author Info](#author-info)

## Description
This project of 'demo.foodomaa.com' Application without using map place api.
The project is build for implementing the 'Save Address Form Google Map' & 'Show Save Address'. For that, Flutter_riverpod is use for stateMangement and address is stored in sqflite database. 

## How To Use

Clone this project and Run this command 'flutter run'.
Or use this apk [flutter_google_map.zip](https://github.com/samuchakraborty/flutter_google_maps/files/6911187/flutter_google_map.zip)



## Demo


https://user-images.githubusercontent.com/61682653/127741424-838c15e1-ed1b-45b3-ac19-662e5f8c3617.mp4




## DataBase

- Store Data Model
```
class StoreData {
  int? id;
  String? addressFromMap;
  String? flatNo;
  String? addressTitle;


  StoreData(
      {this.id,
        this.addressFromMap,
        this.flatNo,
        this.addressTitle,

      });

  Map<String, dynamic> toStore() {
    var map = <String, dynamic>{
      'id': id,
      'address_title': addressTitle,
      'address_from_map': addressFromMap,
      'flat_no': flatNo,

    };

    return map;
  }

  StoreData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    addressTitle = map['address_title'];
    addressFromMap = map['address_from_map'];
    flatNo = map['flat_no'];

  }
}

```


 - Create DataBase 
```
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

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}


```

- Store Function Data
```
  Future storeData(StoreData user) async {
    var dbClient = await db;
    int id = await dbClient.insert(USER_STORE_TABLE, user.toStore());
  //  print(id);
    return id;
  }
```
- Get All Store Data Function
```
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
```
  
## Google Map
  
- Get Current Address
```
  getCurrentAddress({latitude, longitude}) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placeMarks[0];
    print(place);

    _controller = TextEditingController(
        text:
            "${place.name},  ${place.locality}, ${place.administrativeArea}, ${place.country}");

    currentAddress =
        "${place.name}, ${place.locality},${place.administrativeArea},   ${place.country}";
  }
```




- Search Navigator result when textFormfield using  
```
 searchNavigated() {
    locationFromAddress(searchAddress!).then((value) {
      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(value[0].latitude, value[0].longitude),
        zoom: 14,
      )));
      handleTap(LatLng(value[0].latitude, value[0].longitude));
    });
  }
```

- handle user press in google map
```
handleTap(LatLng tapPoint) {
    setState(() {
      marker = [];
      getCurrentAddress(
          latitude: tapPoint.latitude, longitude: tapPoint.longitude);
      marker.add(
        Marker(
            infoWindow: InfoWindow(
              title:
                  'latitude: ${tapPoint.latitude}, longitude: ${tapPoint.longitude}',
            ),
            markerId: MarkerId(
              tapPoint.toString(),
            ),
            draggable: false,
            position: tapPoint),
      );
    });
  }
```



### Flutter Riverpod

- handle Data insert and fecth from sqflite database

```
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
```

- User Location By geoLocator

```
class GeoLocatorRepository extends ChangeNotifier {
  final geoLocatorService = GeoLocatorService();

  Position? currentLocation;

  GeoLocatorRepository() {
    setCurrentLocation();

  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}
```







### Project Images
![HomeScreen](https://user-images.githubusercontent.com/61682653/127740706-7cc1b274-3514-4ad2-ae7f-83bf3b7787aa.png)
![SaveAddress](https://user-images.githubusercontent.com/61682653/127740707-de6c81c0-81c9-4d19-8322-ffc60a847468.png)
![show data](https://user-images.githubusercontent.com/61682653/127740709-5e4cf27c-4d6e-4b7c-8902-45adeb5e632f.png)


## Uses Packages
 
 - google_maps_flutter: ^2.0.6
 - flutter_riverpod: ^0.14.0+3
 - geolocator: ^7.3.1
 - geocoding: ^2.0.0
 - sqflite: ^2.0.0+3
 - path_provider: ^2.0.2

## Author Info

- Linkedin - [@samuchakraborty](https://www.linkedin.com/in/samuchakraborty/)




