import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/aboutUs/model/about_us_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';

var dio = Dio();
var storage = StorageServices();


Future<AboutUsModel?> getAbout()async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.ABOUT);
      if(response.statusCode==200){
        print(response.data['data']);
        AboutUsModel model = AboutUsModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.ABOUT, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.ABOUT);
      if(response!=""){
        return response;
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}