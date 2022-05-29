import 'dart:developer';

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
import 'package:happiness_club/services/navigatorKey.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio(BaseOptions(headers: APIS.HEADER));
var storage = StorageServices();

loginWithPhoneNumber({required context, required String phoneNumber}) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.post(
        APIS.LOGIN,
        data: {"mobile": phoneNumber},
      );
      log(response.data.toString());
      if (response.data['responseStatus'] == "success") {
        Navigator.pushReplacement(
            GlobalVariable.navState.currentContext!,
            CupertinoPageRoute(
                builder: (_) => OtpScreen(
                    token: response.data["data"]["token"].toString())));
      } else {
        showToast(context, response.data["message"]);
      }
    } else {
      showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    //print("Failed to log in");
    showToast(context, "Failed to login. Please check mobile number.");
  }
}

Future validateOtp(context, String otp, String token) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.post(APIS.VALIDATE_OTP,
          queryParameters: {"token": token, "otp": otp});
      log(response.data.toString());
      final userProvider =
          Provider.of<UserModelProvider>(context, listen: false);
      if (response.data['responseStatus'] == 'success') {
        userProvider.addCustomerId(response.data["data"]["id"].toString());
        userProvider.addName(response.data["data"]["full_name"]);
        userProvider.setMembershipDetails(
            response.data["data"]["membership_no"],
            response.data["data"]["expiry_date"]);
        userProvider.setCompanyName(response.data["data"]["company_name"]);
        userProvider.setAccessType(response.data["data"]["access_type"]);
        userProvider.setHcId(response.data["data"]["hc_id"].toString());
        userProvider
            .setHcCompanyId(response.data["data"]["hc_company_id"].toString());

        storage.writeDataToStorage(
            StorageKeys.USER_ID, response.data["data"]["id"].toString());
        storage.writeDataToStorage(StorageKeys.USER_NAME,
            response.data["data"]["full_name"].toString());
        storage.writeDataToStorage(StorageKeys.USER_MEMBERSHIP,
            response.data["data"]["membership_no"].toString());
        storage.writeDataToStorage(StorageKeys.USER_EXP_DATE,
            response.data["data"]["expiry_date"].toString());
        storage.writeDataToStorage(StorageKeys.USER_COMPANY,
            response.data["data"]["company_name"].toString());
        storage.writeDataToStorage(StorageKeys.USER_ACCESS,
            response.data["data"]["access_type"].toString());
        storage.writeDataToStorage(
            StorageKeys.USER_HC_ID, response.data["data"]["hc_id"].toString());
        storage.writeDataToStorage(StorageKeys.USER_HC_COMPANY_ID,
            response.data["data"]["hc_company_id"].toString());
        return true;
      } else {
        showToast(context, response.data['message']);
        return false;
      }
    } else {
      showNoInternetSnackBar(context);
      return false;
    }
  } on DioError catch (e) {
    return false;
    showToast(context, 'Something went wrong. Please try again later.');
  }
}

Future addCustomer(context, String qrResult, String name, String email,
    String number, String company) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var fcm = await FirebaseMessaging.instance.getToken();
      var location = Provider.of<UserModelProvider>(context, listen: false)
          .currentLocation!;
      var response = await dio.post(APIS.ADD_CUSTOMER, queryParameters: {
        "full_name": name,
        " company_name": company,
        "mobile_number": number,
        "email_address": email,
        "event_qr_code": qrResult,
        "latitude": location.latitude,
        "longitude": location.longitude,
        "token": fcm
      });
      if (response.statusCode == 200) {
        showToast(context, response.data["message"]);
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (_) => HomeBase()));
      }
    } else {
      showNoInternetSnackBar(context);
      return null;
    }
  } on DioError catch (e) {
    showToast(
        context, "Unable to complete your request. Please try again later.");
    //print(e.response!.data);
    return null;
  }
}

Future postCustomerHelp(context, String message, String name, String email,
    String number, String company, String type) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.post(APIS.HELP, queryParameters: {
        "full_name": name,
        "company": company,
        "mobile": number,
        "email": email,
        "message": message,
        "type": type
      });
      if (response.statusCode == 200) {
        showToast(context, response.data["message"]);
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (_) => HomeBase()));
      }
    } else {
      showNoInternetSnackBar(context);
      return null;
    }
  } on DioError catch (e) {
    showToast(context, "Unable to send your request. Please try again later");
  }
}

Future loginWithUaePass(context, String userData) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      final userProvider =
          Provider.of<UserModelProvider>(context, listen: false);
      var response = await dio.post(APIS.UAE_PASS_LOGIN,
          queryParameters: {"uaepass_data": userData});
      print(response.data);
      if (response.data['responseStatus'] == "success") {
        log(response.data["data"]["otp"].toString());
        userProvider.updateLoginStatus(true);
        userProvider.addCustomerId(response.data["data"]["id"].toString());
        userProvider.addName(response.data["data"]["full_name"]);
        userProvider.setMembershipDetails(
            response.data["data"]["membership_no"],
            response.data["data"]["expiry_date"]);
        userProvider.setCompanyName(response.data["data"]["company_name"]);
        userProvider.setAccessType(response.data["data"]["access_type"]);
        userProvider.setHcId(response.data["data"]["hc_id"].toString());
        userProvider
            .setHcCompanyId(response.data["data"]["hc_company_id"].toString());

        storage.writeDataToStorage(StorageKeys.LOGGED_IN, "true");
        storage.writeDataToStorage(
            StorageKeys.USER_ID, response.data["data"]["id"].toString());
        storage.writeDataToStorage(StorageKeys.USER_NAME,
            response.data["data"]["full_name"].toString());
        storage.writeDataToStorage(StorageKeys.USER_MEMBERSHIP,
            response.data["data"]["membership_no"].toString());
        storage.writeDataToStorage(StorageKeys.USER_EXP_DATE,
            response.data["data"]["expiry_date"].toString());
        storage.writeDataToStorage(StorageKeys.USER_COMPANY,
            response.data["data"]["company_name"].toString());
        storage.writeDataToStorage(StorageKeys.USER_ACCESS,
            response.data["data"]["access_type"].toString());
        storage.writeDataToStorage(
            StorageKeys.USER_HC_ID, response.data["data"]["hc_id"].toString());
        storage.writeDataToStorage(StorageKeys.USER_HC_COMPANY_ID,
            response.data["data"]["hc_company_id"].toString());

        Navigator.pushReplacement(GlobalVariable.navState.currentContext!,
            CupertinoPageRoute(builder: (_) => HomeBase()));
        showToast(context, "Welcome to Happiness Club");
        //Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>OtpScreen(otp: response.data["data"]["otp"].toString())));
      } else {
        showToast(context, response.data["message"]);
      }
    }
  } on DioError catch (e) {
    print(e);
    showToast(context, "Failed to login.");
  }
}
