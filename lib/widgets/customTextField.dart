import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.labelName,
      required this.hintTextName,
      required this.onChangedFunction,
      this.errorText,
      this.limit,
      this.validateFunction,
      required this.textInputType,
      this.textButtonName,
      this.onPressed,
      this.icon,
        this.initialValue,
        this.controller,
      this.obscureTextTy = false});

  final String labelName;
  final String? initialValue;
  final String hintTextName;
  final String? errorText;
  final TextInputType textInputType;
  final String? textButtonName;
  final ValueChanged onChangedFunction;
  final FormFieldValidator<String>? validateFunction;
  final int? limit;
  final Function()? onPressed;
  final IconData? icon;
  final bool? obscureTextTy;
  final TextEditingController?  controller;

  @override
  Widget build(BuildContext context) {
    return Column(
//              mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            labelName,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
        ),
        TextFormField(
          controller: controller,
          initialValue:initialValue ,
            keyboardType: textInputType,
            // autofocus: true,
            decoration: InputDecoration(
              errorText: errorText,
              hintStyle: TextStyle(color: Colors.red, fontSize: 17),
              hintText: hintTextName,

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              //isDense: true,                      // Added this
              //  contentPadding: EdgeInsets.all(15),

            ),
            onChanged: onChangedFunction,
            obscureText: obscureTextTy!,
            validator: validateFunction,
            inputFormatters: [
              LengthLimitingTextInputFormatter(limit),
            ]),
      ],
    );
  }
}
