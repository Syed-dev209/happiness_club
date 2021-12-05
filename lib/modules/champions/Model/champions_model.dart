class ChampionsModelData {
  int? id;
  String? fullName;
  String? photo;

  ChampionsModelData({
    this.id,
    this.fullName,
    this.photo,
  });
  ChampionsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    fullName = json['full_name']?.toString();
    photo = json['photo']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['photo'] = photo;
    return data;
  }
}

class ChampionsModel {

  String? responseStatus;
  String? message;
  List<ChampionsModelData?>? data;

  ChampionsModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  ChampionsModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <ChampionsModelData>[];
      v.forEach((v) {
        arr0.add(ChampionsModelData.fromJson(v));
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
