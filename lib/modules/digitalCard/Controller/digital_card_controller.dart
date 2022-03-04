import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/digitalCard/Model/digital_card_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

var dio = Dio();
var storage = StorageServices();

Future<DigitalCardModel?> getDigitalCards(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    var response = storage.readDataFromStorage(StorageKeys.DC_BLOB);
    if(response!=""){
     return DigitalCardModel.fromJson(response);
   }
   else {
      if (check) {
        final user = Provider
            .of<UserModelProvider>(context, listen: false)
            .customerId;
        //print(user);
        if (user != "") {
          var response = await dio.post(APIS.DIGITAL_CARD, queryParameters: {
            "customer_id": user
          });
          if (response.statusCode == 200) {
            var imageBlob = response.data["data"];
            DigitalCardModel model = DigitalCardModel.fromJson(response.data);
            storage.writeDataToStorage(StorageKeys.DC_BLOB, model.toJson());
            return model;
          }
        }
        else {
          showToast(context, "You must log in to see your cards");
          return null;
        }
      }
      else {
        var response = storage.readDataFromStorage(StorageKeys.DC_BLOB);
        if (response != "") {
          return response;
        }
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}