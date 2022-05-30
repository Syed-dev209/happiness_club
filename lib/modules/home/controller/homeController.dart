import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/dashboard_model.dart';
import 'package:happiness_club/modules/home/Model/featured_offers_model.dart';
import 'package:happiness_club/modules/home/Model/latest_offers_model.dart';
import 'package:happiness_club/modules/home/Model/most_viewed_offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/services/navigatorKey.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio(BaseOptions(headers: APIS.HEADER));

var storage = StorageServices();

Future getDashboardData(context) async {
  Provider.of<CategoriesOfferProvider>(GlobalVariable.navState.currentContext!,
          listen: false)
      .clearProvider();
  Provider.of<OffersSliderProvider>(GlobalVariable.navState.currentContext!,
          listen: false)
      .clearProvider();
  Provider.of<MostViewedOffersProvider>(GlobalVariable.navState.currentContext!,
          listen: false)
      .clearProvider();
  Provider.of<LatestOffersProvider>(GlobalVariable.navState.currentContext!,
          listen: false)
      .clearProvider();
  Provider.of<FeaturedOffersProvider>(GlobalVariable.navState.currentContext!,
          listen: false)
      .clearProvider();
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      log(APIS.DASHBOARD_DATA);
      var response = await dio.get(APIS.DASHBOARD_DATA);
      if (response.statusCode == 200 &&
          response.data["responseStatus"] == "success") {
        DashboardModel model = DashboardModel.fromJson(response.data);

        ///slider
        OffersSliderModel slider = OffersSliderModel(
            responseStatus: model.responseStatus,
            message: model.message,
            data: model.data!.slides!);
        Provider.of<OffersSliderProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModel(slider);
        storage.writeDataToStorage(StorageKeys.SLIDER, slider.toJson());

        ///most viewed offers
        OffersModel mostViewed = OffersModel(
            responseStatus: model.responseStatus,
            message: model.message,
            data: model.data!.mostViewedOffers);
        Provider.of<MostViewedOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(mostViewed);
        storage.writeDataToStorage(
            StorageKeys.MOST_VIEWED_OFFERS, mostViewed.toJson());

        ///latest offers
        OffersModel latest = OffersModel(
            responseStatus: model.responseStatus,
            message: model.message,
            data: model.data!.latestOffers);
        Provider.of<LatestOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(latest);
        storage.writeDataToStorage(StorageKeys.LATEST_OFFERS, latest.toJson());

        ///featured offers
        OffersModel featured = OffersModel(
            responseStatus: model.responseStatus,
            message: model.message,
            data: model.data!.featuredOffers);
        Provider.of<FeaturedOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(featured);
        storage.writeDataToStorage(
            StorageKeys.FEATURED_OFFERS, featured.toJson());

        ///categories
        var cat = OffersCategoriesModel(
            responseStatus: model.responseStatus,
            message: model.message,
            data: model.data!.categories);
        Provider.of<CategoriesOfferProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModel(cat);
        storage.writeDataToStorage(StorageKeys.CATEGORIES, cat.toJson());
      }
    } else {
      //slider
      var data = storage.readDataFromStorage(StorageKeys.SLIDER);
      if (data != "") {
        OffersSliderModel model = OffersSliderModel.fromJson(data);
        Provider.of<OffersSliderProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModel(model);
      }
      //most viewed
      var response =
          storage.readDataFromStorage(StorageKeys.MOST_VIEWED_OFFERS);
      if (response != "") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<MostViewedOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(model);
      }
      //latest
      var response2 = storage.readDataFromStorage(StorageKeys.LATEST_OFFERS);
      if (response2 != "") {
        OffersModel model = OffersModel.fromJson(response2);
        Provider.of<LatestOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(model);
      }
      //featured
      var response3 = storage.readDataFromStorage(StorageKeys.FEATURED_OFFERS);
      if (response3 != "") {
        OffersModel model = OffersModel.fromJson(response3);
        Provider.of<FeaturedOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(model);
      }
      //categories
      var cat = storage.readDataFromStorage(StorageKeys.CATEGORIES);
      if (cat != "") {
        var model = OffersCategoriesModel.fromJson(cat);
        Provider.of<CategoriesOfferProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModel(model);
      }
      showNoInternetSnackBar(GlobalVariable.navState.currentContext!);
    }
  } on DioError catch (e) {
    //print(e);
    //slider
    var data = storage.readDataFromStorage(StorageKeys.SLIDER);
    if (data != "") {
      OffersSliderModel model = OffersSliderModel.fromJson(data);
      Provider.of<OffersSliderProvider>(GlobalVariable.navState.currentContext!,
              listen: false)
          .addModel(model);
    }
    //most viewed
    var response = storage.readDataFromStorage(StorageKeys.MOST_VIEWED_OFFERS);
    if (response != "") {
      OffersModel model = OffersModel.fromJson(response);
      Provider.of<MostViewedOffersProvider>(
              GlobalVariable.navState.currentContext!,
              listen: false)
          .addModelData(model);
    }
    //latest
    var response2 = storage.readDataFromStorage(StorageKeys.LATEST_OFFERS);
    if (response2 != "") {
      OffersModel model = OffersModel.fromJson(response2);
      Provider.of<LatestOffersProvider>(GlobalVariable.navState.currentContext!,
              listen: false)
          .addModelData(model);
    }
    //featured
    var response3 = storage.readDataFromStorage(StorageKeys.FEATURED_OFFERS);
    if (response3 != "") {
      OffersModel model = OffersModel.fromJson(response3);
      Provider.of<FeaturedOffersProvider>(
              GlobalVariable.navState.currentContext!,
              listen: false)
          .addModelData(model);
    }
    //categories
    var cat = storage.readDataFromStorage(StorageKeys.CATEGORIES);
    if (cat != "") {
      var model = OffersCategoriesModel.fromJson(cat);
      Provider.of<CategoriesOfferProvider>(
              GlobalVariable.navState.currentContext!,
              listen: false)
          .addModel(model);
    }
    showToast(GlobalVariable.navState.currentContext!, "Unable to load data");
  }
}

Future getSliderImages(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      // var ab =await dio.get("https://hpcapi.happinessclub.ae/api/v1/offers/featured?v=123");
      // print(ab.data);
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
    //print(e);
    // print("Sliders failed to load from API");
  }
}

Future getMostViewedOffers(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      LatLng location = Provider.of<UserModelProvider>(context, listen: false)
          .currentLocation!;
      // print(APIS.MOST_VIEWED_OFFERS);
      var response = await dio.get(APIS.MOST_VIEWED_OFFERS, queryParameters: {
        "lat": location.latitude,
        "long": location.longitude
      });
      if (response.statusCode == 200) {
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<MostViewedOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(model);
        storage.writeDataToStorage(
            StorageKeys.MOST_VIEWED_OFFERS, model.toJson());
      }
    } else {
      var response =
          storage.readDataFromStorage(StorageKeys.MOST_VIEWED_OFFERS);
      if (response != "") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<MostViewedOffersProvider>(context, listen: false)
            .addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    //print("Most viewed failed to load from API");
  }
}

Future getLatestOffers(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      LatLng location = Provider.of<UserModelProvider>(context, listen: false)
          .currentLocation!;
      // print(APIS.LATEST_OFFERS);
      var response = await dio.get(APIS.LATEST_OFFERS, queryParameters: {
        "lat": location.latitude,
        "long": location.longitude
      });
      if (response.statusCode == 200) {
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<LatestOffersProvider>(
                GlobalVariable.navState.currentContext!,
                listen: false)
            .addModelData(model);
        storage.writeDataToStorage(StorageKeys.LATEST_OFFERS, model.toJson());
      }
    } else {
      var response = storage.readDataFromStorage(StorageKeys.LATEST_OFFERS);
      if (response != "") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<LatestOffersProvider>(context, listen: false)
            .addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    //  print("latest offers failed to load from API");
  }
}

Future getFeaturedOffers(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {
      LatLng location = Provider.of<UserModelProvider>(context, listen: false)
          .currentLocation!;
      var response = await dio.get(APIS.FEATURED_OFFERS, queryParameters: {
        "lat": location.latitude,
        "long": location.longitude
      });
      if (response.statusCode == 200) {
        // print(response.data);
        OffersModel model = OffersModel.fromJson(response.data);
        Provider.of<FeaturedOffersProvider>(context, listen: false)
            .addModelData(model);
        storage.writeDataToStorage(StorageKeys.FEATURED_OFFERS, model.toJson());
      }
    } else {
      var response = storage.readDataFromStorage(StorageKeys.FEATURED_OFFERS);
      if (response != "") {
        OffersModel model = OffersModel.fromJson(response);
        Provider.of<FeaturedOffersProvider>(context, listen: false)
            .addModelData(model);
      }
      //showNoInternetSnackBar(context);
    }
  } on DioError catch (e) {
    //print("Featured offers failed to load from API");
  }
}
