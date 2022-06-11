import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:happiness_club/widgets/successpop.dart';
import 'package:provider/provider.dart';

var dio = Dio(BaseOptions(headers: APIS.HEADER));

Future scanQrResult(context, String qrResult) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.post(APIS.SCAN_QR, data: {"qrcode": qrResult});
      if (response.statusCode == 200) {
        if (response.data["responseStatus"] == "failed") {
          Navigator.pop(context);
          getErrorPopup();
          return null;
        } else {
          getSuccessPopup();
          //print(response.data);
          return "success";
        }
      }
    } else {
      showNoInternetSnackBar(context);
      return null;
    }
  } on DioError catch (e) {
    getErrorPopup();
    return null;
  }
}

validateCustomer(context, String qrResult) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      final fcm = await FirebaseMessaging.instance.getToken();
      final user =
          Provider.of<UserModelProvider>(context, listen: false).customerId;
      var latLng = Provider.of<UserModelProvider>(context, listen: false)
          .currentLocation!;
      var response = await dio.post(APIS.VALIDATE_QR, queryParameters: {
        "customer_id": user,
        "token": fcm,
        "latitude": latLng.latitude,
        "longitude": latLng.longitude,
        "event_qr_code": qrResult
      });

      if (response.statusCode == 200) {
        showToast(context, response.data["message"]);
      }
    } else {
      showToast(context,
          "Can't process your request now. Please check your Internet connection.");
    }
  } on DioError catch (e) {}
}
