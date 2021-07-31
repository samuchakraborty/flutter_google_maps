import 'package:flutter/material.dart';

 const API_KEY = "AIzaSyD1unmc8okV_PWFfMI5kK2ywr4X7w9xt3I";


ButtonStyle buttonStyleContinue = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.orange.shade800),
  fixedSize: MaterialStateProperty.all(
    Size(
      400,
      60,
    ),
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.orange))),
);






ButtonStyle buttonStyleUseLocation = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.orange.shade800),
  fixedSize: MaterialStateProperty.all(
    Size(
      300,
      40,
    ),
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.orange))),
);