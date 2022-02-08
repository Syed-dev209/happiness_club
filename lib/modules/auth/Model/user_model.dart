import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  String customerId = "";
  String name="Not logged in";
  LatLng? currentLocation;
  addCustomerId(String id){
    customerId = id;
  }
  addName(String nam){
    name=nam;
  }
  updateLoginStatus(bool status){
    loggedIn = true;
  }

  setCurrentLocation(LatLng loc){
    currentLocation = loc;
  }
}