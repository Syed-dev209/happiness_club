class OfferDetailsModelData {
  int? id;
  String? endDate;
  String? title;
  String? offerDiscount;
  String? offerLogoType;
  int? viewCount;
  String? description;
  int? categoryId;
  String? categoryName;
  String? latitude;
  String? longitude;
  String? location;
  String? stateName;
  String? featuredImage;
  String? ratings;
  double? distance;

  OfferDetailsModelData({
    this.id,
    this.endDate,
    this.title,
    this.offerDiscount,
    this.offerLogoType,
    this.viewCount,
    this.description,
    this.categoryId,
    this.categoryName,
    this.latitude,
    this.longitude,
    this.location,
    this.stateName,
    this.featuredImage,
    this.ratings,
    this.distance,
  });
  OfferDetailsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    endDate = json['end_date']?.toString();
    title = json['title']?.toString();
    offerDiscount = json['offer_discount']?.toString();
    offerLogoType = json['offer_logo_type']?.toString();
    viewCount = json['view_count']?.toInt();
    description = json['description']?.toString();
    categoryId = json['category_id']?.toInt();
    categoryName = json['category_name']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    location = json['location']?.toString();
    stateName = json['state_name']?.toString();
    featuredImage = json['featured_image']?.toString();
    ratings = json['ratings']?.toString();
    distance = json['distance']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['end_date'] = endDate;
    data['title'] = title;
    data['offer_discount'] = offerDiscount;
    data['offer_logo_type'] = offerLogoType;
    data['view_count'] = viewCount;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['state_name'] = stateName;
    data['featured_image'] = featuredImage;
    data['ratings'] = ratings;
    data['distance'] = distance;
    return data;
  }
}

class OfferDetailsModel {
  String? responseStatus;
  String? message;
  OfferDetailsModelData? data;

  OfferDetailsModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? OfferDetailsModelData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['responseStatus'] = responseStatus;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
