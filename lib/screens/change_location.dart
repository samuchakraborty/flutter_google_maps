import 'package:flutter/material.dart';

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.red,size: 30,), hintText: "Enter City Name"),
            onChanged: (value) {},
          ),
        ),
        // body: TextFormField(
        //   decoration: InputDecoration(suffixIcon: Icon(Icons.search)),
        // ),
      ),
    );
  }
}
