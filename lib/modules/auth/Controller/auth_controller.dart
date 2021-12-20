import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/otp_screen.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();
var storage = StorageServices();



loginWithPhoneNumber({required context,required String phoneNumber})async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.LOGIN,data: {
        "mobile":phoneNumber
      });
      if(response.data['responseStatus']=="success"){
        print(response.data["data"]["otp"]);

        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>OtpScreen(otp: response.data["data"]["otp"].toString())));
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