import 'package:flutter/material.dart';

showNoInternetSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("No Internet connection"),
    behavior: SnackBarBehavior.floating,
  ));
}
