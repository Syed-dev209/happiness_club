import 'package:flutter/cupertino.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';




class FeaturedOffersProvider extends ChangeNotifier{
  OffersModel? modelData ;
  String state = StorageKeys.STATE_LOADING;
  addModelData(OffersModel data){
    modelData = data;
    state = StorageKeys.STATE_FINISHED;
    notifyListeners();
  }

  clearProvider(){
    modelData = null;
    state = StorageKeys.STATE_LOADING;
    notifyListeners();
  }
}