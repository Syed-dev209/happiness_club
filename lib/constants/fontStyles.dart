import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:provider/provider.dart';

class FontStyles {
  static TextStyle PoppinsStyle(double fontSize,Color colors , { FontWeight fontWeight=FontWeight.normal} ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: StorageServices().readDataFromStorage(StorageKeys.LANGUAGE)=="" ?"Poppins":
      StorageServices().readDataFromStorage(StorageKeys.LANGUAGE)==0?"Poppins":"Tajawal",
      fontWeight: fontWeight,
      color: colors
    );
  }
}
