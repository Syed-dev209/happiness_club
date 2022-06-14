import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/services/navigatorKey.dart';
import 'package:provider/provider.dart';

class OffersSliderModelData {
  int? offerId;
  String? imageFilename, type;

  OffersSliderModelData({
    this.offerId,
    this.imageFilename,
  });
  OffersSliderModelData.fromJson(Map<String, dynamic> json) {
    offerId = json['id']?.toInt() ?? 0;
    imageFilename = json['image_filename']?.toString() ?? '';
    type = json['type']?.toString() ?? '';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['image_filename'] = imageFilename;
    return data;
  }
}

class OffersSliderModel {
  String? responseStatus;
  String? message;
  List<OffersSliderModelData?>? data;

  OffersSliderModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  OffersSliderModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <OffersSliderModelData>[];
      v.forEach((v) {
        arr0.add(OffersSliderModelData.fromJson(v));
      });
      this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['responseStatus'] = responseStatus;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}

class OffersSliderProvider extends ChangeNotifier {
  OffersSliderModel? modelData;
  addModel(OffersSliderModel data) {
    clearProvider();
    List<OffersSliderModelData?>? list = [...data.data!];
    data.data!.clear();
    if (Provider.of<UserModelProvider>(GlobalVariable.navState.currentContext!,
            listen: false)
        .loggedIn) {
      for (var i in list) {
        if (i!.type == 'event') {
          data.data!.add(i);
        }
      }
      for (var i in list) {
        if (i!.type == 'luckyDraw') {
          data.data!.add(i);
        }
      }
    }
    for (var i in list) {
      if (i!.type != 'event' && i.type != 'luckyDraw') {
        data.data!.add(i);
      }
    }
    modelData = data;
    notifyListeners();
  }

  clearProvider() {
    modelData = null;
    notifyListeners();
  }
}
