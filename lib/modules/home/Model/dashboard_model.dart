import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';

class DashboardModelDataFeaturedOffers {

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
  double? distance;

  DashboardModelDataFeaturedOffers({
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
    this.distance,
  });
  DashboardModelDataFeaturedOffers.fromJson(Map<String, dynamic> json) {
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

class DashboardModelDataLatestOffers {
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
  double? distance;

  DashboardModelDataLatestOffers({
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
    this.distance,
  });
  DashboardModelDataLatestOffers.fromJson(Map<String, dynamic> json) {
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

class DashboardModelDataMostViewedOffers {
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
  double? distance;

  DashboardModelDataMostViewedOffers({
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
    this.distance,
  });
  DashboardModelDataMostViewedOffers.fromJson(Map<String, dynamic> json) {
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

class DashboardModelDataCategories {
  int? id;
  String? categoryName;
  String? imageFilename;
  int? offersCount;

  DashboardModelDataCategories({
    this.id,
    this.categoryName,
    this.imageFilename,
    this.offersCount,
  });
  DashboardModelDataCategories.fromJson(Map<String, dynamic> json) {
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

class DashboardModelDataSlides {
  int? offerId;
  String? imageFilename;

  DashboardModelDataSlides({
    this.offerId,
    this.imageFilename,
  });
  DashboardModelDataSlides.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id']?.toInt();
    imageFilename = json['image_filename']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['image_filename'] = imageFilename;
    return data;
  }
}

class DashboardModelData {
  List<OffersSliderModelData?>? slides;
  List<OffersCategoriesModelData?>? categories;
  List<OffersModelData?>? mostViewedOffers;
  List<OffersModelData?>? latestOffers;
  List<OffersModelData?>? featuredOffers;

  DashboardModelData({
    this.slides,
    this.categories,
    this.mostViewedOffers,
    this.latestOffers,
    this.featuredOffers,
  });
  DashboardModelData.fromJson(Map<String, dynamic> json) {
    if (json['slides'] != null) {
      final v = json['slides'];
      final arr0 = <OffersSliderModelData>[];
      v.forEach((v) {
        arr0.add(OffersSliderModelData.fromJson(v));
      });
      slides = arr0;
    }
    if (json['categories'] != null) {
      final v = json['categories'];
      final arr0 = <OffersCategoriesModelData>[];
      v.forEach((v) {
        arr0.add(OffersCategoriesModelData.fromJson(v));
      });
      categories = arr0;
    }
    if (json['mostViewedOffers'] != null) {
      final v = json['mostViewedOffers'];
      final arr0 = <OffersModelData>[];
      v.forEach((v) {
        arr0.add(OffersModelData.fromJson(v));
      });
      mostViewedOffers = arr0;
    }
    if (json['latestOffers'] != null) {
      final v = json['latestOffers'];
      final arr0 = <OffersModelData>[];
      v.forEach((v) {
        arr0.add(OffersModelData.fromJson(v));
      });
      latestOffers = arr0;
    }
    if (json['featuredOffers'] != null) {
      final v = json['featuredOffers'];
      final arr0 = <OffersModelData>[];
      v.forEach((v) {
        arr0.add(OffersModelData.fromJson(v));
      });
      featuredOffers = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (slides != null) {
      final v = slides;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['slides'] = arr0;
    }
    if (categories != null) {
      final v = categories;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['categories'] = arr0;
    }
    if (mostViewedOffers != null) {
      final v = mostViewedOffers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['mostViewedOffers'] = arr0;
    }
    if (latestOffers != null) {
      final v = latestOffers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['latestOffers'] = arr0;
    }
    if (featuredOffers != null) {
      final v = featuredOffers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['featuredOffers'] = arr0;
    }
    return data;
  }
}

class DashboardModel {
  String? responseStatus;
  String? message;
  DashboardModelData? data;

  DashboardModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  DashboardModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? DashboardModelData.fromJson(json['data']) : null;
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
