import 'package:flutter/material.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  String customerId = "";
  addCustomerId(String id){
    customerId = id;
  }
  updateLoginStatus(bool status){
    loggedIn = true;
  }
}