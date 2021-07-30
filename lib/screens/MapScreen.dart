import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/blocs/application_bloc.dart';
import 'package:flutter_google_maps_task/widgets/customTextField.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> marker = [];
  late String currentAddress;

  static const _initialCameraPosition =
  CameraPosition(target: LatLng(22.3569, 91.7832), zoom: 13);

  TextEditingController _controller = TextEditingController();
  bool myMarker = false;

  getCurrentAddress({latitude, longitude}) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    Placemark place = placeMarks[0];
    print(place);

    _controller = TextEditingController(
        text:
            "${place.name}, ${place.subLocality},  ${place.locality}, ${place.country}");

    currentAddress =
        "${place.name}, ${place.subLocality}, ${place.locality},  ${place.country}";
  }

  GoogleMapController? mapController;
  String? searchAddress;

  void onMapCreate(controller) {
    setState(() {
      mapController = controller;
    });
  }

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

  getMyLocation({latitude, longitude}) {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    )));
  }

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
            draggable: true,
            position: tapPoint),
      );

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //

    handleTap(LatLng(22.3569, 91.7832));
    // marker = [];
    //
    // marker.add(Marker(
    //     infoWindow: InfoWindow(
    //       title:
    //       'latitude: ${22.3569}, longitude: ${91.7832}',
    //     ),
    //     markerId: MarkerId("origins"),
    //     position: LatLng(22.3569, 91.7832)));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: applicationBloc.currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 400,
                      child: GoogleMap(
                        onMapCreated: onMapCreate,
                        mapType: MapType.normal,
                        onTap: handleTap,
                        markers:
//                         myMarker == true
//                             ? {
//                                 Marker(
//                                     markerId: MarkerId("origin"),
//                                     infoWindow:
//                                         InfoWindow(title: currentAddress),
// //                              infoWindow: InfoWindow(title: "Origin"),
//                                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                                         BitmapDescriptor.hueGreen),
//                                     position: LatLng(
//                                         applicationBloc
//                                             .currentLocation!.latitude,
//                                         applicationBloc
//                                             .currentLocation!.longitude))
//                               }
//                             :
                        Set.from(marker),

                        onCameraMove: (position) {
                          setState(() {
                            marker = [];
                            print(position.target);
                            getCurrentAddress(
                                latitude: position.target.latitude,
                                longitude: position.target.longitude);

                            marker.add(Marker(
                                infoWindow: InfoWindow(
                                  title:
                                      'latitude: ${position.target.latitude}, longitude: ${position.target.longitude}',
                                ),
                                markerId: MarkerId(position.target.toString()),
                                position: position.target));
                          });
                        },
                        initialCameraPosition: _initialCameraPosition,
                        //zoomControlsEnabled: false,
                        // myLocationButtonEnabled: true,
                        // myLocationEnabled: true,
                      ),
                    ),
                    Positioned(
                      right: 15,
                      left: 15,
                      top: 30,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 20),
                          decoration: InputDecoration(
                            hintText: "Enter city Name",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: searchNavigated,
                              iconSize: 30,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              searchAddress = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 120,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {

                            // getCurrentAddress(
                            //     latitude:
                            //         applicationBloc.currentLocation!.latitude,
                            //     longitude:
                            //         applicationBloc.currentLocation!.longitude);

                            handleTap(LatLng(
                                applicationBloc.currentLocation!.latitude,
                                applicationBloc.currentLocation!.longitude));
                            getMyLocation(
                                latitude:
                                    applicationBloc.currentLocation!.latitude,
                                longitude:
                                    applicationBloc.currentLocation!.longitude);
                          });
                        },
                        child: Text(
                          "Use My Current Location",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: buttonStyleContinue,
                      ),
                      CustomTextField(
                        //  initialValue: currentAddress!,
                        controller: _controller,
                        labelName: "Your Location",
                        onChangedFunction: (value) {},
                        textInputType: TextInputType.text,
                        hintTextName: '',
                        textButtonName: "",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelName: "Flat No",
                        onChangedFunction: (value) {},
                        textInputType: TextInputType.text,
                        hintTextName: '',
                        textButtonName: '',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        labelName: "Address Title",
                        onChangedFunction: (value) {},
                        textInputType: TextInputType.text,
                        hintTextName: '',
                        textButtonName: '',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(currentAddress);
                        },
                        child: Text(
                          "SAVE ADDRESS",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: buttonStyleContinue,
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
