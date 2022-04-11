import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/prizeHistory/model/prize_history_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

import '../../../constants/network_constants.dart';
import '../../../services/storage_service.dart';

var dio = Dio( BaseOptions(
    headers: APIS.HEADER
));

var storage = StorageServices();

Future<PrizeHistoryModel?> getPrizeHistory(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      final user = Provider.of<UserModelProvider>(context,listen: false);
      log(user.hcId);
      var response = await dio.get(APIS.PRIZE_HISTORY,queryParameters: {"customer_hc_id":user.hcId});
      print(response.data);
      if(response.data["responseStatus"]=="success" && response.statusCode==200){
        PrizeHistoryModel model = PrizeHistoryModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.PRIZE_HISTORY, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage(StorageKeys.PRIZE_HISTORY);
      if(response!=""){
        return PrizeHistoryModel.fromJson(response);
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    print(e);
    return null;
  }
}