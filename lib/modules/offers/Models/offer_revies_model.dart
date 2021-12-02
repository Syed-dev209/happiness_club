class OfferReviesModelData {
  int? offerId;
  int? ratingStars;
  String? feedbacks;

  OfferReviesModelData({
    this.offerId,
    this.ratingStars,
    this.feedbacks,
  });
  OfferReviesModelData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id']?.toInt();
    ratingStars = json['rating_stars']?.toInt();
    feedbacks = json['feedbacks']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['rating_stars'] = ratingStars;
    data['feedbacks'] = feedbacks;
    return data;
  }
}

class OfferReviesModel {
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
