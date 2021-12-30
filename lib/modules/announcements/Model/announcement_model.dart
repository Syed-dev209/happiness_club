///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class AnnouncementModelData {
/*
{
  "id": 6,
  "title": "HC VIDEO BLOG CHAMPIONSHIP",
  "description": "<p>We are all excited with the start of EXPO 2020!</p>\r\n<p>Happiness Club is ending 2021 and starting 2022 with another initiative that highlights a special milestone for Dubai and the UAE.</p>\r\n<p>&nbsp;</p>\r\n<p>Event: Video Blog Championship &ndash; EXPO Edition</p>\r\n<p>Videos to be submitted on or before: 1st February 2022</p>\r\n<p>&nbsp;</p>\r\n<p>Rules:</p>\r\n<ul>\r\n<li>Contestants can participate with one video only</li>\r\n<li>Contestants should appear at least once in the video</li>\r\n<li>Contestants to solely capture the videos, and should not reuse videos from the net</li>\r\n<li>Video time - Minimum: 3 minutes and Maximum: 7 minutes</li>\r\n<li>Video must be professional and diverse, and should include several pavilions</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>Happiness Club can use and post the videos on any of its platforms</p>\r\n<p>5 winners will receive Grand Prizes, 5 runner-up and maybe more.</p>",
  "image_url": null,
  "dated": "2021-12-30"
}
*/

  int? id;
  String? title;
  String? description;
  String? imageUrl;
  String? dated;

  AnnouncementModelData({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.dated,
  });
  AnnouncementModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    description = json['description']?.toString();
    imageUrl = json['image_url']?.toString();
    dated = json['dated']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['dated'] = dated;
    return data;
  }
}

class AnnouncementModel {
/*
{
  "responseStatus": "success",
  "message": "",
  "data": [
    {
      "id": 6,
      "title": "HC VIDEO BLOG CHAMPIONSHIP",
      "description": "<p>We are all excited with the start of EXPO 2020!</p>\r\n<p>Happiness Club is ending 2021 and starting 2022 with another initiative that highlights a special milestone for Dubai and the UAE.</p>\r\n<p>&nbsp;</p>\r\n<p>Event: Video Blog Championship &ndash; EXPO Edition</p>\r\n<p>Videos to be submitted on or before: 1st February 2022</p>\r\n<p>&nbsp;</p>\r\n<p>Rules:</p>\r\n<ul>\r\n<li>Contestants can participate with one video only</li>\r\n<li>Contestants should appear at least once in the video</li>\r\n<li>Contestants to solely capture the videos, and should not reuse videos from the net</li>\r\n<li>Video time - Minimum: 3 minutes and Maximum: 7 minutes</li>\r\n<li>Video must be professional and diverse, and should include several pavilions</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>Happiness Club can use and post the videos on any of its platforms</p>\r\n<p>5 winners will receive Grand Prizes, 5 runner-up and maybe more.</p>",
      "image_url": null,
      "dated": "2021-12-30"
    }
  ]
}
*/

  String? responseStatus;
  String? message;
  List<AnnouncementModelData?>? data;

  AnnouncementModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <AnnouncementModelData>[];
      v.forEach((v) {
        arr0.add(AnnouncementModelData.fromJson(v));
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
