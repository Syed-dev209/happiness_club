import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/services/storage_service.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  String customerId = "";
  String name="Not logged in";
  String memberShip="";
  String expDate="";
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

  setMembershipDetails(String memNum, String date){
    memberShip = memNum;
    expDate = date;
  }


  logOutUser(){
    StorageServices()..clearAllData();
    loggedIn = false;
    customerId="";
    name = "Not logged in";
    memberShip = "";
    expDate="";
    notifyListeners();
  }
}