class FavoritesModelData {
  int? id;
  String? endDate;
  String? title;
  String? offerDiscount;
  String? offerLogoType;
  int? viewCount;
  int? categoryId;
  String? categoryName;
  String? latitude;
  String? longitude;
  String? location;
  String? stateName;
  String? featuredImage;
  String? ratings;

  FavoritesModelData({
    this.id,
    this.endDate,
    this.title,
    this.offerDiscount,
    this.offerLogoType,
    this.viewCount,
    this.categoryId,
    this.categoryName,
    this.latitude,
    this.longitude,
    this.location,
    this.stateName,
    this.featuredImage,
    this.ratings,
  });
  FavoritesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    endDate = json['end_date']?.toString();
    title = json['title']?.toString();
    offerDiscount = json['offer_discount']?.toString();
    offerLogoType = json['offer_logo_type']?.toString();
    viewCount = json['view_count']?.toInt();
    categoryId = json['category_id']?.toInt();
    categoryName = json['category_name']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    location = json['location']?.toString();
    stateName = json['state_name']?.toString();
    featuredImage = json['featured_image']?.toString();
    ratings = json['ratings']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['end_date'] = endDate;
    data['title'] = title;
    data['offer_discount'] = offerDiscount;
    data['offer_logo_type'] = offerLogoType;
    data['view_count'] = viewCount;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['state_name'] = stateName;
    data['featured_image'] = featuredImage;
    data['ratings'] = ratings;
    return data;
  }
}

class FavoritesModel {
  String? responseStatus;
  String? message;
  List<FavoritesModelData?>? data;

  FavoritesModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <FavoritesModelData>[];
      v.forEach((v) {
        arr0.add(FavoritesModelData.fromJson(v));
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
