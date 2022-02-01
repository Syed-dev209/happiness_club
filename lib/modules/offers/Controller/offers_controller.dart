import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_details_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_revies_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';



var dio = Dio();
var storage = StorageServices();

Future getAllOffers(context,int start, int end)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.ALL_OFFERS,queryParameters:{
        "start":start,
        "end":end
      });
      if(response.statusCode==200){
        OffersModel model = OffersModel.fromJson(response.data);
        if(start==0){
          Provider.of<AllOffersProvider>(context,listen: false).addModel(model);
        }
        else{
          Provider.of<AllOffersProvider>(context,listen: false).addModelData(model.data!);
        }
        storage.writeDataToStorage("offers$start $end", model.toJson());
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage("offers$start $end");
      if(response!=""){
        Provider.of<AllOffersProvider>(context,listen: false).addModel(OffersModel.fromJson(response));
      }
    }
  }
  on DioError catch(e){
   // print(e);
    var response = storage.readDataFromStorage("offers$start $end");
    if(response!=""){
      Provider.of<AllOffersProvider>(context,listen: false).addModel(OffersModel.fromJson(response));
    }
  }
}

Future<OfferDetailsModel?> getOffersDetail({required String offerId})async{
  log(offerId);

  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      LatLng location = await LocationService().getCurrentLocation();
      var response = await dio.get("${APIS.OFFER_DETAILS}/$offerId",queryParameters: {
        "lat":location.latitude,
        "long":location.longitude
      });
      if (response.statusCode == 200) {
        print(response.data);
        OfferDetailsModel model = OfferDetailsModel.fromJson(response.data);
        storage.writeDataToStorage(offerId, model.toJson());
        return model;
      }
      else {
        return null;
      }
    }
    else {
      var response = storage.readDataFromStorage(offerId);
      if (response != "") {
        OfferDetailsModel model = OfferDetailsModel.fromJson(response);
        return model;
      }
      else {
        return null;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
  catch(e){
    return null;
  }
}


Future<OfferLocationModel?> getOffersLocation({required String offerId})async{
  try {
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get("${APIS.OFFER_LOCATION}/$offerId");
      if(response.statusCode == 200){
        OfferLocationModel model = OfferLocationModel.fromJson(response.data);
        storage.writeDataToStorage(offerId, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      var response = storage.readDataFromStorage(offerId);
      if(response!=""){
        return OfferLocationModel.fromJson(response);
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}


Future<OfferReviesModel?> getOfferReviews({required String offerId})async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get("${APIS.OFFER_REVIEWS}/$offerId");
      if(response.statusCode== 200){
        OfferReviesModel model = OfferReviesModel.fromJson(response.data);
        storage.writeDataToStorage(offerId, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      var response = storage.readDataFromStorage(offerId);
      if(response!=""){
        return OfferReviesModel.fromJson(response);
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}

Future<OffersModel?> getOffersByCategory({required String catId})async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.OFFER_BY_CATEGORY,queryParameters: {
        "cat":catId
      });
      if(response.statusCode==200){
        OffersModel model = OffersModel.fromJson(response.data);
        storage.writeDataToStorage("category$catId", model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      var response = storage.readDataFromStorage("category$catId");
      if(response!=""){
        return OffersModel.fromJson(response);
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}


Future postAReview(context, String offerId,String review,double rating)async{

  try{
    bool check = await InternetService.checkConnectivity();
    String userId = Provider.of<UserModelProvider>(context,listen: false).customerId;
    print(userId);
    print(offerId);
    if(check){
      var response = await dio.post(APIS.ADD_REVIEW,data: {
        "stars" :rating,
        "review":review,
        "offer_id":offerId,
        "customer_id": userId
      });
      if(response.statusCode == 200){
        print(response.data);
        showToast(context, "Thank you for rating us.");
      }
    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(w){
    print(w);
    showToast(context, "Unable to post review");
  }
}


addViewToOffer(String offerId)async {
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.ADD_VIEW,queryParameters: {
        "offer_id":offerId
      });
      print("view added to offer");
    }
  }
  catch(e){

  }
}