import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';

var dio = Dio(BaseOptions(
    headers: APIS.HEADER
));
var storage = StorageServices();

Future<OffersModel?> getNearbyOffers(LatLng currentPosition,int start, int end) async {
 // print("Start==>$start");
  //print("End===>$end");
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      //LatLng location = await LocationService().getCurrentLocation();
      log(APIS.NEARBY_OFFERS);
      var response = await dio.get(
          APIS.NEARBY_OFFERS,
          options: Options(
            headers: {
              'Content-Type': 'application/json'
            }
          ),
          queryParameters: {
        "lat":currentPosition.latitude,
        "long":currentPosition.longitude,
        "start":start,
        "end":end
      });
      if (response.statusCode == 200) {
        OffersModel model = OffersModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.NEARBY_OFFERS, model.toJson());
        return model;
      } else {
        var response = storage.readDataFromStorage(StorageKeys.NEARBY_OFFERS);
        if (response != "") {
          return OffersModel.fromJson(response);
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  } on DioError catch (e) {
    //print(e);
    var response = storage.readDataFromStorage(StorageKeys.NEARBY_OFFERS);
    if (response != "") {
      return OffersModel.fromJson(response);
    } else {
      return null;
    }
  }
}


Future<OffersModel?> getMapNearbyOffers(context,LatLng currentPosition,double zoom)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.NEARBY_MAP_OFFERS,queryParameters: {
        "lat":currentPosition.latitude,
        "long":currentPosition.longitude,
        "zoom":zoom
      });
      if(response.statusCode == 200){
        //print(response.data);
        OffersModel model = OffersModel.fromJson(response.data);
        return model;
      }
      return null;
    }
    else{
      showNoInternetSnackBar(context);
      return null;
    }
  }
 on DioError catch(e){
    return null;
 }
}