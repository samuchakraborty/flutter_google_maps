import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/screens/MapScreen.dart';
import 'package:flutter_google_maps_task/screens/showData.dart';
import '../constants.dart';

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
