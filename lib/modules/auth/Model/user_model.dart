import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/services/storage_service.dart';

class UserModelProvider extends ChangeNotifier{
  bool loggedIn = false;
  String customerId = "";
  String name="Not logged in";
  String memberShip="";
  String expDate="";
  String company="";
  String accessType="";
  String hcId="";
  String hcCompanyId="";
  LatLng? currentLocation;
  int? language;
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
  setCompanyName(String comp){
    company = comp;
  }
  setAccessType(String type){
    accessType = type;
  }
  setHcId(String id){
    hcId = id;
  }
  setHcCompanyId(String id){
    hcCompanyId = id;
  }
  setLanguage(int lang){
    language= lang;
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