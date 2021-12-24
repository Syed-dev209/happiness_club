import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/otp_screen.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();
var storage = StorageServices();



loginWithPhoneNumber({required context,required String phoneNumber})async{
  print('in spi');
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.LOGIN,data: {
        "mobile":phoneNumber
      });
      print(response.data);
      if(response.data['responseStatus']=="success"){
        print(response.data["data"]["otp"]);
        Provider.of<UserModelProvider>(context,listen: false).addCustomerId(response.data["data"]["id"].toString());
        Provider.of<UserModelProvider>(context,listen: false).addName(response.data["data"]["full_name"]);
        storage.writeDataToStorage(StorageKeys.USER_ID, response.data["data"]["id"].toString());
        storage.writeDataToStorage(StorageKeys.USER_NAME, response.data["data"]["full_name"].toString());
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>OtpScreen(otp: response.data["data"]["otp"].toString())));
      }
      else{
        showToast(context, response.data["message"]);
      }

    }
    else{
      showNoInternetSnackBar(context);
      // var response = storage.readDataFromStorage(StorageKeys.LOGGED_IN);
      // if(response!=""){
      //   Provider.of<UserModelProvider>(context,listen: false).updateLoginStatus(true);
      // }
    }
  }
  on DioError catch(e){
    print("Failed to log in");
    showToast(context, "Failed to login. Please check mobile number.");
  }
}


Future addCustomer(context,String qrResult,String name, String email, String number,String company)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var fcm = await FirebaseMessaging.instance.getToken();
      var location = await LocationService().getCurrentLocation();
      var response = await dio.post(APIS.ADD_CUSTOMER,queryParameters: {
        "full_name":name,
        " company_name":company,
        "mobile_number":number,
        "email_address":email,
        "event_qr_code":qrResult,
        "latitude":location.latitude,
        "longitude":location.longitude,
        "token":fcm
      });
      if(response.statusCode==200){
        showToast(context, response.data["message"]);
        Navigator.pushReplacement(context,  CupertinoPageRoute(builder: (_)=>HomeBase()));
      }
    }
    else{
      showNoInternetSnackBar(context);
      return null;
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to complete your request. Please try again later.");
    print(e.response!.data);
    return null;
  }
}


Future postCustomerHelp(context,String message,String name, String email, String number,String company)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.HELP,queryParameters: {
        "full_name":name,
        "company":company,
        "mobile":number,
        "email":email,
        "message":message
      });
      if(response.statusCode == 200){
        showToast(context, response.data["message"]);
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>HomeBase()));
      }
    }
    else{
      showNoInternetSnackBar(context);
      return null;
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to send your request. Please try again later");
  }
}