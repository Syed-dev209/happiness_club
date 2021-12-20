import 'package:flutter/material.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  updateLoginStatus(bool status){
    loggedIn = true;
  }
}