import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FontStyle {
  static TextStyle PoppinsStyle(double fontSize,Color colors , { FontWeight fontWeight=FontWeight.normal} ) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: colors
    );
  }
}
