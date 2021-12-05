import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/champions/Model/champions_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';


var dio = Dio();
var storage = StorageServices();

Future<ChampionsModel?> getChampions(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.CHAMPIONS);
      print(response.data);
      if(response.statusCode == 200){
        ChampionsModel model = ChampionsModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.CHAMPIONS, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage(StorageKeys.CHAMPIONS);
      if(response!=""){
        return ChampionsModel.fromJson(response);
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