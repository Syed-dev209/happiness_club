
class LuckDrawModelData {

  int? id;
  String? eventTitle;
  String? eventLocation;
  String? eventDatetime;
  int? eventStatus;
  String? eventImage;

  LuckDrawModelData({
    this.id,
    this.eventTitle,
    this.eventLocation,
    this.eventDatetime,
    this.eventStatus,
    this.eventImage,
  });
  LuckDrawModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    eventTitle = json['event_title']?.toString();
    eventLocation = json['event_location']?.toString();
    eventDatetime = json['event_datetime']?.toString();
    eventStatus = json['event_status']?.toInt();
    eventImage = json['event_image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['event_title'] = eventTitle;
    data['event_location'] = eventLocation;
    data['event_datetime'] = eventDatetime;
    data['event_status'] = eventStatus;
    data['event_image'] = eventImage;
    return data;
  }
}

class LuckDrawModel {

  String? responseStatus;
  String? message;
  List<LuckDrawModelData?>? data;

  LuckDrawModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  LuckDrawModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <LuckDrawModelData>[];
      v.forEach((v) {
        arr0.add(LuckDrawModelData.fromJson(v));
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
