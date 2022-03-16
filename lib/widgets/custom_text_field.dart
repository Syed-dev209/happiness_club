import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/constants/fontStyles.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  TextInputType? keyboardType;
  bool? obscureText;
  MultiValidator validator;
  List<TextInputFormatter>? inputFormatters;
  CustomTextField({required this.controller, this.keyboardType= TextInputType.name, required this.labelText, this.obscureText=false,required this.validator,this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        obscureText: obscureText!,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: "$labelText",
            hintStyle: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }
}
