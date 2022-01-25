class DigitalCardModelData {


  List<String?>? fazaaCard;
  List<String?>? happinessCard;

  DigitalCardModelData({
    this.fazaaCard,
    this.happinessCard,
  });
  DigitalCardModelData.fromJson(Map<String, dynamic> json) {
    if (json['fazaaCard'] != null) {
      final v = json['fazaaCard'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      fazaaCard = arr0;
    }
    if (json['happinessCard'] != null) {
      final v = json['happinessCard'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      happinessCard = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (fazaaCard != null) {
      final v = fazaaCard;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['fazaaCard'] = arr0;
    }
    if (happinessCard != null) {
      final v = happinessCard;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['happinessCard'] = arr0;
    }
    return data;
  }
}

class DigitalCardModel {
  String? responseStatus;
  String? message;
  DigitalCardModelData? data;

  DigitalCardModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  DigitalCardModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? DigitalCardModelData.fromJson(json['data']) : null;
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
