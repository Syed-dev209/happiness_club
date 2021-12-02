class OfferLocationModelData {
  String? offerId;
  String? latitude;
  String? longitude;
  String? contactPerson;
  String? contactPhoneNumber;
  String? contactEmailAddress;
  String? offerAddress;
  String? stateName;

  OfferLocationModelData({
    this.offerId,
    this.latitude,
    this.longitude,
    this.contactPerson,
    this.contactPhoneNumber,
    this.contactEmailAddress,
    this.offerAddress,
    this.stateName,
  });
  OfferLocationModelData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    contactPerson = json['contact_person']?.toString();
    contactPhoneNumber = json['contact_phone_number']?.toString();
    contactEmailAddress = json['contact_email_address']?.toString();
    offerAddress = json['offer_address']?.toString();
    stateName = json['state_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['contact_person'] = contactPerson;
    data['contact_phone_number'] = contactPhoneNumber;
    data['contact_email_address'] = contactEmailAddress;
    data['offer_address'] = offerAddress;
    data['state_name'] = stateName;
    return data;
  }
}

class OfferLocationModel {

  String? responseStatus;
  String? message;
  List<OfferLocationModelData?>? data;

  OfferLocationModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  OfferLocationModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <OfferLocationModelData>[];
      v.forEach((v) {
        arr0.add(OfferLocationModelData.fromJson(v));
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
