import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/offers/Models/offer_details_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_revies_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';



var dio = Dio();
var storage = StorageServices();



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