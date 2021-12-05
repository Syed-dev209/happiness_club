class CompaniesModelData {

  int? id;
  String? title;
  String? logo;

  CompaniesModelData({
    this.id,
    this.title,
    this.logo,
  });
  CompaniesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    logo = json['logo']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['logo'] = logo;
    return data;
  }
}

class CompaniesModel {
  String? responseStatus;
  String? message;
  List<CompaniesModelData?>? data;

  CompaniesModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  CompaniesModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <CompaniesModelData>[];
      v.forEach((v) {
        arr0.add(CompaniesModelData.fromJson(v));
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
