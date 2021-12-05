import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';


var dio = Dio();


Future postMessage(context,String name, String email, String message)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      FormData formData = FormData.fromMap({
        "full_name":name,
        "email_address":email,
        "message":message
      });
      var response = await dio.post(APIS.CONTACT,data: formData);
      if(response.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.data["data"]}')));

      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorry your request cannot be processed now')));
      }

    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorry your request cannot be processed now')));
  }
}