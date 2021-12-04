import 'package:flutter/cupertino.dart';
import 'package:happiness_club/constants/storage_keys.dart';

import 'offers_model.dart';


class MostViewedOffersProvider extends ChangeNotifier{
  OffersModel? modelData;
  String state = StorageKeys.STATE_LOADING;

  addModelData(OffersModel data){
    modelData = null;
    modelData = data;
    state = StorageKeys.STATE_FINISHED;
    notifyListeners();
  }

  clearProvider(){
    state = StorageKeys.STATE_LOADING;
    modelData = null;
    notifyListeners();
  }
}