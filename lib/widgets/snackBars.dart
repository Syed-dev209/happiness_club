import 'package:flutter/material.dart';

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
    duration: Duration(milliseconds: 400),
  ));
}