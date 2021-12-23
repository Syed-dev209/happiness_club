import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();

Future scanQrResult(context,String qrResult)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.SCAN_QR,data: {
        "qrcode":qrResult
      });
      if(response.statusCode == 200){
        if(response.data["responseStatus"]=="failed"){
          showToast(context, response.data["message"]);
        }
        else{
          showToast(context, "Successfully scanned.");
        }
        print(response.data);
      }
    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to process your request now");
  }
}


validateCustomer(context, String qrResult)async{
 try {
   bool check = await InternetService.checkConnectivity();
   if (check) {
     final fcm = await FirebaseMessaging.instance.getToken();
     final user = Provider
         .of<UserModelProvider>(context, listen: false)
         .customerId;
     var latLng = await LocationService().getCurrentLocation();
     var response = await dio.post(APIS.VALIDATE_QR,queryParameters: {
       "customer_id":user,
       "token":fcm,
       "latitude":latLng.latitude,
       "longitude":latLng.longitude,
       "event_qr_code":qrResult
     });

     if(response.statusCode == 200){
       showToast(context, response.data["message"]);
     }
   }
   else{
     showToast(context, "Can't process your request now. Please check your Internet connection.");
   }
 }
 on DioError catch(e){

 }

}