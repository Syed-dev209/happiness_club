import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';

showNoInternetSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(LocaleKeys.no_internet.tr()),
    behavior: SnackBarBehavior.floating,
  ));
}


showToast(context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 1000),
  ));
}

getLoader(){
  return Center(
    child: SizedBox(
      height: 30,
      width: 30,
      child: SpinKitSpinningLines(
        color: Color(ColorCodes.GOLDEN_COLOR),
      ),
    )
    
    // Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
  );
}