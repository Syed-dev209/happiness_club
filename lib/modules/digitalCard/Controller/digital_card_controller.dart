import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

var dio = Dio();
var storage = StorageServices();

Future<dynamic> getDigitalCards(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      final user = Provider.of<UserModelProvider>(context,listen: false).customerId;
      if(user!="") {
        var response = await dio.post(APIS.DIGITAL_CARD, queryParameters: {
          "customer_id": user
        });
        if (response.statusCode == 200) {
          var imageBlob = response.data["data"];
          storage.writeDataToStorage(StorageKeys.DC_BLOB, imageBlob);
          return imageBlob;
        }
      }
      else{
        showToast(context, "You must log in to see your cards");
        return null;
      }
      }
    else{
      var response = storage.readDataFromStorage(StorageKeys.DC_BLOB);
      if(response!=""){
        return response;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}