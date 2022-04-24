class DigitalCardsModel {
  DigitalCardsModel({
    required this.responseStatus,
    required this.message,
    required this.data,
  });
  late final String responseStatus;
  late final String message;
  late final Data data;

  DigitalCardsModel.fromJson(Map<String, dynamic> json){
    responseStatus = json['responseStatus'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['responseStatus'] = responseStatus;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.fazaaCard,
    required this.happinessCard,
  });
  late final List<FazaaCard> fazaaCard;
  late final List<HappinessCard> happinessCard;

  Data.fromJson(Map<String, dynamic> json){
    fazaaCard = List.from(json['fazaaCard']).map((e)=>FazaaCard.fromJson(e)).toList();
    happinessCard = List.from(json['happinessCard']).map((e)=>HappinessCard.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fazaaCard'] = fazaaCard.map((e)=>e.toJson()).toList();
    _data['happinessCard'] = happinessCard.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FazaaCard {
  FazaaCard({
    required this.front,
    required this.back,
  });
  late final String front;
  late final String back;

  FazaaCard.fromJson(Map<String, dynamic> json){
    front = json['front'];
    back = json['back'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['front'] = front;
    _data['back'] = back;
    return _data;
  }
}

class HappinessCard {
  HappinessCard({
    required this.front,
    required this.back,
  });
  late final String front;
  late final String back;

  HappinessCard.fromJson(Map<String, dynamic> json){
    front = json['front'];
    back = json['back'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['front'] = front;
    _data['back'] = back;
    return _data;
  }
}