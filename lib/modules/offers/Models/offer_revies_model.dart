///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class OfferReviesModelData {
/*
{
  "offer_id": 1551,
  "rating_stars": 4,
  "feedbacks": "nice",
  "full_name": "Abdullah",
  "created_at": "2021-12-24 14:50:16"
}
*/

  int? offerId;
  int? ratingStars;
  String? feedbacks;
  String? fullName;
  String? createdAt;

  OfferReviesModelData({
    this.offerId,
    this.ratingStars,
    this.feedbacks,
    this.fullName,
    this.createdAt,
  });
  OfferReviesModelData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id']?.toInt();
    ratingStars = json['rating_stars']?.toInt();
    feedbacks = json['feedbacks']?.toString();
    fullName = json['full_name']?.toString();
    createdAt = json['created_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['rating_stars'] = ratingStars;
    data['feedbacks'] = feedbacks;
    data['full_name'] = fullName;
    data['created_at'] = createdAt;
    return data;
  }
}

class OfferReviesModel {
/*
{
  "responseStatus": "success",
  "message": "",
  "data": [
    {
      "offer_id": 1551,
      "rating_stars": 4,
      "feedbacks": "nice",
      "full_name": "Abdullah",
      "created_at": "2021-12-24 14:50:16"
    }
  ]
}
*/

  String? responseStatus;
  String? message;
  List<OfferReviesModelData?>? data;

  OfferReviesModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  OfferReviesModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <OfferReviesModelData>[];
      v.forEach((v) {
        arr0.add(OfferReviesModelData.fromJson(v));
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
