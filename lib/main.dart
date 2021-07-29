import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/blocs/application_bloc.dart';
import 'package:flutter_google_maps_task/screens/add_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MapScreen(),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final CameraPosition kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   final applicationBloc = Provider.of<ApplicationBloc>(context);
  //
  //   applicationBloc.setCurrentLocation();
  //
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          applicationBloc.currentLocation == null
              ? CircularProgressIndicator()
              : Container(
                  height: 400,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            applicationBloc.currentLocation!.latitude,
                            applicationBloc.currentLocation!.longitude),
                        zoom: 14.0),
                    //zoomControlsEnabled: false,
                    // myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          AddDetails(
              initialValue: applicationBloc.currentLocation!.longitude.toString()


          ),
        ],
      ),
    );
  }
}
