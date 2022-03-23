import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/announcements/announcement_details_screen.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/modules/prizeHistory/screens/prize_history_screen.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'navigatorKey.dart';

class PushNotificationServices {
  static PushNotificationServices _pushNotificationServices =
  PushNotificationServices._internal();
  factory PushNotificationServices() {
    return _pushNotificationServices;
  }
  PushNotificationServices._internal();

  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  var dio = Dio();
  var storage = StorageServices();
  Future<String> getDeviceToken() async {
    String? token = await _fcm.getToken();
    //print("Device Token:- $token");
    return token ?? "";
  }

  requestPermission() {
    _fcm.requestPermission();
  }

  initializeNotifications(context) async {
    // bool isLoggedIn = Provider.of<LoginChecker>(context,listen: false).getUserStatus;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ///jab app open hu
     // print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showOverlayNotification((context) {
          return GestureDetector(
            onTap: () {
              if(message.data["type"]=="announcement") {
                ///announcement when
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.of(GlobalVariable.navState.currentContext!).push(
                      MaterialPageRoute(
                          builder: (_) =>
                             AnnouncementDetailsScreen(id: message.data["aid"])
                      )
                  );
                });
              }
              else if(message.data["type"]=="offer"){
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.of(GlobalVariable.navState.currentContext!).push(
                      MaterialPageRoute(
                          builder: (_) =>
                              OfferDetailsScreen(offerId: message.data["offer_id"])
                      )
                  );
                });
              }
              else if(message.data["type"]=="prize"){
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.of(GlobalVariable.navState.currentContext!).push(
                      MaterialPageRoute(
                          builder: (_) =>
                              PrizeHistoryScreen()
                      )
                  );
                });
              }
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: SafeArea(
                child: ListTile(
                  leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: Image.asset(Images.LOGO),
                      ),
                    ),
                  ),
                  title: Text(notification.title!),
                  subtitle: Text(notification.body!),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      }),
                ),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ///jab app background me hu kill nhi hui hu
      //print('A new onMessageOpenedApp event was published!');
      //print(message.data);
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        if(message.data["type"]=="announcement") {
          ///announcement when
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        AnnouncementDetailsScreen(id: message.data["aid"])
                )
            );
          });
        }
        else if(message.data["type"]=="offer"){
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        OfferDetailsScreen(offerId: message.data["offer_id"])
                )
            );
          });
        }
        else if(message.data["type"]=="prize"){
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        PrizeHistoryScreen()
                )
            );
          });
        }
      });
    });

    ///when app is killed and opens on notification
    RemoteMessage? terminatedMessage = await _fcm.getInitialMessage();
    if (terminatedMessage != null) {
      if (terminatedMessage.notification != null) {
        if(terminatedMessage.data["type"]=="announcement") {
          ///announcement when
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        AnnouncementDetailsScreen(id: terminatedMessage.data["aid"])
                )
            );
          });
        }
        else if(terminatedMessage.data["type"]=="offer"){
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        OfferDetailsScreen(offerId: terminatedMessage.data["offer_id"])
                )
            );
          });
        }
        else if(terminatedMessage.data["type"]=="prize"){
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!).push(
                MaterialPageRoute(
                    builder: (_) =>
                        PrizeHistoryScreen()
                )
            );
          });
        }
      }
    }
  }

  registerUserToken()async{
    try{
      String device = await getDeviceToken();
      bool check = await InternetService.checkConnectivity();
      if(check){
        var isRegister = storage.readDataFromStorage(StorageKeys.REGISTERED);
        if(isRegister==""){
         var response =  await dio.post(APIS.REGISTER_TOKEN,data: {
            "token":device
          });
          if(response.statusCode == 200){
            storage.writeDataToStorage(StorageKeys.REGISTERED, true);
           // print("Device registered");
          }
          }
      }
    }
    on DioError catch(e){

    }
  }


}
