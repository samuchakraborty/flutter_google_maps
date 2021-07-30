import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/blocs/application_bloc.dart';
import 'package:flutter_google_maps_task/screens/MapScreen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          primarySwatch: Colors.blue,
         visualDensity: VisualDensity.adaptivePlatformDensity
         // primaryColor: Colors.black
        ),
        home: MapScreen(),
      ),
    );
  }
}

