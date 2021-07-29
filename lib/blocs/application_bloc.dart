import 'package:flutter/cupertino.dart';
import 'package:flutter_google_maps_task/services/geo_locator_service.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBloc extends ChangeNotifier {
  final geoLocatorService = GeoLocatorService();

  Position? currentLocation;

  ApplicationBloc() {
    setCurrentLocation();
  }



  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }


}
