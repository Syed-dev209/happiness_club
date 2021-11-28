import 'package:flutter/cupertino.dart';
import 'package:happiness_club/constants/storage_keys.dart';

class FeaturedOffersModelData {

  int? id;
  String? endDate;
  String? title;
  String? offerDiscount;
  String? featuredImage;
  String? offerLogoType;
  int? viewCount;
  int? categoryId;
  String? categoryName;
  String? imageGallery;
  String? coordinates;
  double? distance;

  FeaturedOffersModelData({
    this.id,
    this.endDate,
    this.title,
    this.offerDiscount,
    this.featuredImage,
    this.offerLogoType,
    this.viewCount,
    this.categoryId,
    this.categoryName,
    this.imageGallery,
    this.coordinates,
    this.distance,
  });
  FeaturedOffersModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    endDate = json['end_date']?.toString();
    title = json['title']?.toString();
    offerDiscount = json['offer_discount']?.toString();
    featuredImage = json['featured_image']?.toString();
    offerLogoType = json['offer_logo_type']?.toString();
    viewCount = json['view_count']?.toInt();
    categoryId = json['category_id']?.toInt();
    categoryName = json['category_name']?.toString();
    imageGallery = json['image_gallery']?.toString();
    coordinates = json['coordinates']?.toString();
    distance = json['distance']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['end_date'] = endDate;
    data['title'] = title;
    data['offer_discount'] = offerDiscount;
    data['featured_image'] = featuredImage;
    data['offer_logo_type'] = offerLogoType;
    data['view_count'] = viewCount;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['image_gallery'] = imageGallery;
    data['coordinates'] = coordinates;
    data['distance'] = distance;
    return data;
  }
}

class FeaturedOffersModel {
  String? responseStatus;
  String? message;
  List<FeaturedOffersModelData?>? data;

  FeaturedOffersModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  FeaturedOffersModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <FeaturedOffersModelData>[];
      v.forEach((v) {
        arr0.add(FeaturedOffersModelData.fromJson(v));
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


class FeaturedOffersProvider extends ChangeNotifier{
  FeaturedOffersModel? modelData ;
  String state = StorageKeys.STATE_LOADING;
  addModelData(FeaturedOffersModel data){
    modelData = data;
    state = StorageKeys.STATE_FINISHED;
    notifyListeners();
  }

  clearProvider(){
    modelData = null;
    state = StorageKeys.STATE_LOADING;
    notifyListeners();
  }
}