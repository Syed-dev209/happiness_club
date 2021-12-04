import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';


var dio = Dio();
var storage = StorageServices();


Future<OfferLocationModel?> getNearbyOffers(LatLng currentPosition)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.NEARBY_OFFERS);
      if(response.statusCode == 200){
        print(response.data);
        OfferLocationModel model = OfferLocationModel.fromJson(response.data);
        return model;
      }
      else{
        return null;
      }
    }
    else{
      return null;
    }
  }
  on DioError catch(e){
    return null;
  }
}