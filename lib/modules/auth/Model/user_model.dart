import 'package:flutter/material.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  String customerId = "";
  String name="Not logged in";
  addCustomerId(String id){
    customerId = id;
  }
  addName(String nam){
    name=nam;
  }
  updateLoginStatus(bool status){
    loggedIn = true;
  }
}