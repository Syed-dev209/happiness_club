import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';

var dio = Dio();
var storage = StorageServices();


Future<String?> getAbout()async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.ABOUT);
      if(response.statusCode==200){
        print(response.data['data']);
        storage.writeDataToStorage(StorageKeys.ABOUT, response.data['data']);
        return response.data['data'];
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