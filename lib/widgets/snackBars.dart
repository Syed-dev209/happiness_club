import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showNoInternetSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("No Internet connection"),
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
    child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
  );
}