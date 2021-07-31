import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/screens/MapScreen.dart';
import 'package:flutter_google_maps_task/screens/showData.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity
          // primaryColor: Colors.black
          ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

         body: Container(
           margin: EdgeInsets.only(left: 20, right: 20),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,

             children: [

               ElevatedButton(
                 onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MapScreen(),),);
                 },
                 child: Text(
                   "Save Address",
                   style: TextStyle(fontSize: 20),
                 ),
                  style: buttonStyleContinue,
               ),
               SizedBox(height: 30,),

               ElevatedButton(
                 onPressed: () {

                   Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowData()));
                 },
                 child: Text(
                   "Show Save Address",
                   style: TextStyle(fontSize: 20),
                 ),
                  style: buttonStyleContinue,
               ),




             ],),
         ),


      ),
    );
  }
}
