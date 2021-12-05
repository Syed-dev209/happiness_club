import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_details_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_revies_model.dart';
import 'package:happiness_club/services/internet_service.dart';
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

  }
}

Future<OfferDetailsModel?> getOffersDetail({required String offerId})async{

  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.get("${APIS.OFFER_DETAILS}/$offerId");
      if (response.statusCode == 200) {
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