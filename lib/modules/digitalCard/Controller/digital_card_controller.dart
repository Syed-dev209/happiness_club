import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/digitalCard/Model/digital_card_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';

var dio = Dio(BaseOptions(headers: APIS.HEADER));
var storage = StorageServices();

Future<DigitalCardsModel?> getDigitalCards(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
      if (check) {
        final user =
            Provider.of<UserModelProvider>(context, listen: false).customerId;
        print(APIS.DIGITAL_CARD);
        if (user != "") {
          var response = await dio
              .post(APIS.DIGITAL_CARD, queryParameters: {"customer_id": user});
            DigitalCardsModel model = DigitalCardsModel.fromJson(response.data);
            storage.writeDataToStorage(StorageKeys.DC_BLOB, model.toJson());
            return model;

        } else {
          showToast(context, "You must log in to see your cards");
          return null;
        }
      } else {
        var response = storage.readDataFromStorage(StorageKeys.DC_BLOB);
        if (response != "") {
          return response;
        }
      }
    
  } on DioError catch (e) {
    return null;
  }
}
