import 'package:flutter/material.dart';
import 'package:flutter_google_maps_task/widgets/customTextField.dart';

import '../constants.dart';


class AddDetails extends StatelessWidget {
  final String initialValue;
  AddDetails({
    required
    this.initialValue});

  @override
  Widget build(BuildContext context) {
    return    Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          CustomTextField(
            initialValue: initialValue,
            labelName: "Your Location",
            onChangedFunction: (value) {},
            textInputType: TextInputType.text,
            hintTextName: '',
            textButtonName: "CHANGE",
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

          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: (){},
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Icon(icons, size: 30,),
            //     //SizedBox(width: 6,),
            //     Text(
            //       buttonName,
            //       style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
            //     ),
            //   ],
            // ),
            child:  Text(
              "SAVE ADDRESS",
              style: TextStyle(fontSize: 20),
            ),
            style: buttonStyleContinue,
          )

        ],
      ),
    );
  }
}
