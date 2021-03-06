import 'package:intl/intl.dart';

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class CompanyDetailsModelDataLuckyWinners {
/*
{
  "id": 2,
  "full_name": "Babar Aslam",
  "photo": "",
  "gift_title": "T-shirt"
}
*/

  int? id;
  String? fullName;
  String? photo;
  String? giftTitle;

  CompanyDetailsModelDataLuckyWinners({
    this.id,
    this.fullName,
    this.photo,
    this.giftTitle,
  });
  CompanyDetailsModelDataLuckyWinners.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    fullName = json['full_name']?.toString();
    photo = json['photo']?.toString();
    giftTitle = json['gift_title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['photo'] = photo;
    data['gift_title'] = giftTitle;
    return data;
  }
}

class CompanyDetailsModelDataChampionshipWinners {
/*
{
  "id": 1,
  "full_name": "James Doe",
  "position": 1,
  "medal_won": "Gold",
  "photo": null
}
*/

  int? id;
  String? fullName;
  int? position;
  String? medalWon;
  String? photo, eventTitle, date;

  CompanyDetailsModelDataChampionshipWinners({
    this.id,
    this.fullName,
    this.position,
    this.medalWon,
    this.photo,
  });
  CompanyDetailsModelDataChampionshipWinners.fromJson(Map<String, dynamic> json) {
    var dateFormatter = DateFormat("dd MMM, yyy");
    id = json['id']?.toInt();
    fullName = json['full_name']?.toString();
    position = json['position']?.toInt();
    medalWon = json['medal_won']?.toString();
    photo = json['photo']?.toString();
    eventTitle = json["event_title"];
    date = dateFormatter.format(DateTime.parse(json["MID(t2.event_datetime,1,10)"]));
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['position'] = position;
    data['medal_won'] = medalWon;
    data['photo'] = photo;
    return data;
  }
}

class CompanyDetailsModelDataChampions {
/*
{
  "id": 2,
  "full_name": "Ahmed Al Zarouni",
  "photo": "https://happinessclub.ae/storage/team/happiness-club-ahmed-al-zarouni-2.png"
}
*/

  int? id;
  String? fullName;
  String? photo;

  CompanyDetailsModelDataChampions({
    this.id,
    this.fullName,
    this.photo,
  });
  CompanyDetailsModelDataChampions.fromJson(Map<String, dynamic> json) {
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

class CompanyDetailsModelDataCompanyInfo {
/*
{
  "id": 1,
  "title": "ALEC",
  "logo": "https://happinessclub.ae/storage/members/happiness-club-alec-1.png",
  "total_championships": 0,
  "total_winners": 0,
  "total_staff": 0,
  "trophy_winners": 0,
  "total_gold": 0,
  "total_silver": 0,
  "total_bronze": 0
}
*/

  int? id;
  String? title;
  String? logo;
  int? totalChampionships;
  int? totalWinners;
  int? totalStaff;
  int? trophyWinners;
  int? totalGold;
  int? totalSilver;
  int? totalBronze;

  CompanyDetailsModelDataCompanyInfo({
    this.id,
    this.title,
    this.logo,
    this.totalChampionships,
    this.totalWinners,
    this.totalStaff,
    this.trophyWinners,
    this.totalGold,
    this.totalSilver,
    this.totalBronze,
  });
  CompanyDetailsModelDataCompanyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    logo = json['logo']?.toString();
    totalChampionships = json['total_championships']?.toInt();
    totalWinners = json['total_winners']?.toInt();
    totalStaff = json['total_staff']?.toInt();
    trophyWinners = json['trophy_winners']?.toInt();
    totalGold = json['total_gold']?.toInt();
    totalSilver = json['total_silver']?.toInt();
    totalBronze = json['total_bronze']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['logo'] = logo;
    data['total_championships'] = totalChampionships;
    data['total_winners'] = totalWinners;
    data['total_staff'] = totalStaff;
    data['trophy_winners'] = trophyWinners;
    data['total_gold'] = totalGold;
    data['total_silver'] = totalSilver;
    data['total_bronze'] = totalBronze;
    return data;
  }
}

class CompanyDetailsModelData {
/*
{
  "companyInfo": [
    {
      "id": 1,
      "title": "ALEC",
      "logo": "https://happinessclub.ae/storage/members/happiness-club-alec-1.png",
      "total_championships": 0,
      "total_winners": 0,
      "total_staff": 0,
      "trophy_winners": 0,
      "total_gold": 0,
      "total_silver": 0,
      "total_bronze": 0
    }
  ],
  "champions": [
    {
      "id": 2,
      "full_name": "Ahmed Al Zarouni",
      "photo": "https://happinessclub.ae/storage/team/happiness-club-ahmed-al-zarouni-2.png"
    }
  ],
  "championshipWinners": [
    {
      "id": 1,
      "full_name": "James Doe",
      "position": 1,
      "medal_won": "Gold",
      "photo": null
    }
  ],
  "luckyWinners": [
    {
      "id": 2,
      "full_name": "Babar Aslam",
      "photo": "",
      "gift_title": "T-shirt"
    }
  ]
}
*/

  List<CompanyDetailsModelDataCompanyInfo?>? companyInfo;
  List<CompanyDetailsModelDataChampions?>? champions;
  List<CompanyDetailsModelDataChampionshipWinners?>? championshipWinners;
  List<CompanyDetailsModelDataLuckyWinners?>? luckyWinners;

  CompanyDetailsModelData({
    this.companyInfo,
    this.champions,
    this.championshipWinners,
    this.luckyWinners,
  });
  CompanyDetailsModelData.fromJson(Map<String, dynamic> json) {
    if (json['companyInfo'] != null) {
      final v = json['companyInfo'];
      final arr0 = <CompanyDetailsModelDataCompanyInfo>[];
      v.forEach((v) {
        arr0.add(CompanyDetailsModelDataCompanyInfo.fromJson(v));
      });
      companyInfo = arr0;
    }
    if (json['champions'] != null) {
      final v = json['champions'];
      final arr0 = <CompanyDetailsModelDataChampions>[];
      v.forEach((v) {
        arr0.add(CompanyDetailsModelDataChampions.fromJson(v));
      });
      champions = arr0;
    }
    if (json['championshipWinners'] != null) {
      final v = json['championshipWinners'];
      final arr0 = <CompanyDetailsModelDataChampionshipWinners>[];
      v.forEach((v) {
        arr0.add(CompanyDetailsModelDataChampionshipWinners.fromJson(v));
      });
      championshipWinners = arr0;
    }
    if (json['luckyWinners'] != null) {
      final v = json['luckyWinners'];
      final arr0 = <CompanyDetailsModelDataLuckyWinners>[];
      v.forEach((v) {
        arr0.add(CompanyDetailsModelDataLuckyWinners.fromJson(v));
      });
      luckyWinners = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (companyInfo != null) {
      final v = companyInfo;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['companyInfo'] = arr0;
    }
    if (champions != null) {
      final v = champions;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['champions'] = arr0;
    }
    if (championshipWinners != null) {
      final v = championshipWinners;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['championshipWinners'] = arr0;
    }
    if (luckyWinners != null) {
      final v = luckyWinners;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['luckyWinners'] = arr0;
    }
    return data;
  }
}

class CompanyDetailsModel {
/*
{
  "responseStatus": "success",
  "message": "",
  "data": {
    "companyInfo": [
      {
        "id": 1,
        "title": "ALEC",
        "logo": "https://happinessclub.ae/storage/members/happiness-club-alec-1.png",
        "total_championships": 0,
        "total_winners": 0,
        "total_staff": 0,
        "trophy_winners": 0,
        "total_gold": 0,
        "total_silver": 0,
        "total_bronze": 0
      }
    ],
    "champions": [
      {
        "id": 2,
        "full_name": "Ahmed Al Zarouni",
        "photo": "https://happinessclub.ae/storage/team/happiness-club-ahmed-al-zarouni-2.png"
      }
    ],
    "championshipWinners": [
      {
        "id": 1,
        "full_name": "James Doe",
        "position": 1,
        "medal_won": "Gold",
        "photo": null
      }
    ],
    "luckyWinners": [
      {
        "id": 2,
        "full_name": "Babar Aslam",
        "photo": "",
        "gift_title": "T-shirt"
      }
    ]
  }
}
*/

  String? responseStatus;
  String? message;
  CompanyDetailsModelData? data;

  CompanyDetailsModel({
    this.responseStatus,
    this.message,
    this.data,
  });
  CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    responseStatus = json['responseStatus']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? CompanyDetailsModelData.fromJson(json['data']) : null;
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
