import 'package:flutter/cupertino.dart';

class OffersCategoriesModelData {
  int? id;
  String? categoryName;
  String? imageFilename;
  int? offersCount;

  OffersCategoriesModelData({
    this.id,
    this.categoryName,
    this.imageFilename,
    this.offersCount,
  });
  OffersCategoriesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    categoryName = json['category_name']?.toString();
    imageFilename = json['image_filename']?.toString();
    offersCount = json['offers_count']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['image_filename'] = imageFilename;
    data['offers_count'] = offersCount;
    return data;
  }
}

class OffersCategoriesModel {
/*
{
  "responseStatus": "success",
  "message": "",
  "data": [
    {
      "id": 11,
      "category_name": "Others",
      "image_filename": "https://hpc.softlinks.ae/public/storage/offer_categories/hpc-others-11.png",
      "offers_count": 103
    }
  ]
}
*/

  String? responseStatus;
  String? message;
  List<OffersCategoriesModelData?>? data;

  OffersCategoriesModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  OffersCategoriesModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <OffersCategoriesModelData>[];
      v.forEach((v) {
        arr0.add(OffersCategoriesModelData.fromJson(v));
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

class CategoriesOfferProvider extends ChangeNotifier {
  OffersCategoriesModel? modelData;
  addModel(OffersCategoriesModel data) {
    clearProvider();
    modelData = data;
    notifyListeners();
  }

  clearProvider() {
    modelData = null;
    notifyListeners();
  }
}
