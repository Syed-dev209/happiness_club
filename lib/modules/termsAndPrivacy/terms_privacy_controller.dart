import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';


var dio = Dio(BaseOptions(
    headers: APIS.HEADER
));
var storage = StorageServices();


Future<String?>  getTermsAndPrivacy(String type)async{
  try{
    String url="";
    if(type == Constants.PRIVACY){
      url = APIS.PRIVACY;
    }
    else{
      url = APIS.TERMS;
    }

    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(url);
      if(response.statusCode==200){
        if(type == Constants.PRIVACY){
          storage.writeDataToStorage(StorageKeys.PRIVACY, response.data['data']);
        }
        else{
          storage.writeDataToStorage(StorageKeys.TERMS, response.data['data']);
        }
        return response.data['data'];
      }
      else{return null;}
    }
  else{
    var response;
    if(type == Constants.PRIVACY){
      response = storage.readDataFromStorage(StorageKeys.PRIVACY);
    }
    else{
      response = storage.readDataFromStorage(StorageKeys.TERMS);
    }
    return response;
    }
  }
  on DioError catch(e){
    return null;
  }
}