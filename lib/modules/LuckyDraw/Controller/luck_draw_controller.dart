import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/notification_services.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

import '../../../constants/network_constants.dart';
import '../../../constants/storage_keys.dart';
import '../Model/lucky_draw_model.dart';


var dio = Dio( BaseOptions(
    headers: APIS.HEADER
));
var storage = StorageServices();

Future<LuckDrawModel?> getLuckDrawEvents(context)async{
try {
  bool check = await InternetService.checkConnectivity();
  if (check) {
    var response = await dio.get(APIS.LUCKY_DRAW_EVENTS);
    log(response.data.toString());
    if (response.data["responseStatus"] == "success" &&
        response.statusCode == 200) {
      LuckDrawModel model = LuckDrawModel.fromJson(response.data);
      storage.writeDataToStorage(StorageKeys.LUCK_DRAW_EVENTS, model.toJson());
      return model;
    }
    else {
      return null;
    }
  }
  else {
    showNoInternetSnackBar(context);
    var response = storage.readDataFromStorage(StorageKeys.LUCK_DRAW_EVENTS);
    if (response != "") {
      return LuckDrawModel.fromJson(response);
    }
    else {
      return null;
    }
  }
}
on DioError catch(e){
  log(e.toString());
  return null;
}

}


Future<bool> subscribeToEvent(context,String eventId)async{
try{
  bool check = await InternetService.checkConnectivity();
  if(check){
    final user = Provider.of<UserModelProvider>(context,listen: false);
    var mapData = {
      "customer_id":user.customerId,
      "event_id":eventId,
      "customer_hc_id":user.hcId,
      "customer_hc_company_id":user.hcCompanyId,
      "customer_company_name":user.company,
      "token":await PushNotificationServices().getDeviceToken()
    };
    
    var response = await dio.post(APIS.SUBSCRIBE_EVENTS,data: mapData);
    // if(response.statusCode==200 ){
    //   showToast(context,response.data["message"]);
    // }
  }
  else{
    showNoInternetSnackBar(context);
  }

  return true;
}
on DioError catch(e){
  print(e);
  showToast(context,"Unable tio register. Please try again later.");
return true;
}
}