import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

class FontStyles {
  static TextStyle PoppinsStyle(double fontSize,Color colors , { FontWeight fontWeight=FontWeight.normal} ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: "Poppins",
      fontWeight: fontWeight,
      color: colors
    );
  }
}
