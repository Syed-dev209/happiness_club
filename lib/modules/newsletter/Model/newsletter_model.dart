class NewsletterModelData {
  String? title;
  String? pdfFileName;
  String? imageFilename;

  NewsletterModelData({
    this.title,
    this.pdfFileName,
    this.imageFilename,
  });
  NewsletterModelData.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    pdfFileName = json['pdf_file_name']?.toString();
    imageFilename = json['image_filename']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['pdf_file_name'] = pdfFileName;
    data['image_filename'] = imageFilename;
    return data;
  }
}

class NewsletterModel {
  String? responseStatus;
  String? message;
  List<NewsletterModelData?>? data;

  NewsletterModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  NewsletterModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <NewsletterModelData>[];
      v.forEach((v) {
        arr0.add(NewsletterModelData.fromJson(v));
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
