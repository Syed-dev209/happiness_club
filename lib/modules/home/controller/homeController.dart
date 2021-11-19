import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();
var storage = StorageServices();

Future getSliderImages(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      var response = await dio.get(APIS.SLIDER_IMAGED);
      if (response.statusCode == 200) {
        OffersSliderModel model = OffersSliderModel.fromJson(response.data);
        Provider.of<OffersSliderProvider>(context, listen: false)
            .addModel(model);
        storage.writeDataToStorage(StorageKeys.SLIDER, model.toJson());
      }
    } else {
      var data = storage.readDataFromStorage(StorageKeys.SLIDER);
      if (data != "") {
        OffersSliderModel model = OffersSliderModel.fromJson(data);
        Provider.of<OffersSliderProvider>(context, listen: false)
            .addModel(model);
      }
      showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    print("Sliders failed to load from API");
  }
}
