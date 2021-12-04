import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/featured_offers_model.dart';
import 'package:happiness_club/modules/home/Model/latest_offers_model.dart';
import 'package:happiness_club/modules/home/Model/most_viewed_offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();
var storage = StorageServices();

Future getSliderImages(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {

      var response = await dio.get(APIS.SLIDER_IMAGED);
      if (response.statusCode == 200) {
        OffersSliderModel model = OffersSliderModel.fromJson(response.data);
        Provider.of<OffersSliderProvider>(context, listen: false)
            .addModel(model);
        storage.writeDataToStorage(StorageKeys.SLIDER, model.toJson());
      }
    } else {
      var data = storage.readDataFromStorage(StorageKeys.SLIDER);
      if (data != "") {
        OffersSliderModel model = OffersSliderModel.fromJson(data);
        Provider.of<OffersSliderProvider>(context, listen: false)
            .addModel(model);
      }
      showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    print("Sliders failed to load from API");
  }
}


Future getMostViewedOffers(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.MOST_VIEWED_OFFERS);
      if(response.statusCode==200){
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<MostViewedOffersProvider>(context,listen: false).addModelData(model);
        storage.writeDataToStorage(StorageKeys.MOST_VIEWED_OFFERS, model.toJson());
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.MOST_VIEWED_OFFERS);
      if(response!="") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<MostViewedOffersProvider>(context,listen: false).addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }
  }
  on DioError catch (e) {
    print("Most viewed failed to load from API");
  }
}

Future getLatestOffers(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.LATEST_OFFERS);
      if(response.statusCode==200){
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<LatestOffersProvider>(context,listen: false).addModelData(model);
        storage.writeDataToStorage(StorageKeys.LATEST_OFFERS, model.toJson());
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.LATEST_OFFERS);
      if(response!=""){
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<LatestOffersProvider>(context,listen: false).addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }
  }
  on DioError catch (e) {
    print("latest offers failed to load from API");
  }
}

Future getFeaturedOffers(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.FEATURED_OFFERS);
      if(response.statusCode==200){
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<FeaturedOffersProvider>(context,listen: false).addModelData(model);
        storage.writeDataToStorage(StorageKeys.FEATURED_OFFERS, model.toJson());
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.FEATURED_OFFERS);
      if(response!="") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<FeaturedOffersProvider>(context,listen: false).addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }

  }
  on DioError catch (e) {
    print("Featured offers failed to load from API");
  }
}

