import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/newsletter/Model/newsletter_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';


var dio = Dio(BaseOptions(
    headers: APIS.HEADER
));
var storage = StorageServices();


Future<NewsletterModel?> getNewsLetters(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.NEWSLETTER);
      if(response.statusCode==200){
        NewsletterModel model = NewsletterModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.NEWSLETTERS, model.toJson());
        return model;
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.NEWSLETTERS);
      if(response!=""){
        return NewsletterModel.fromJson(response);
      }
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to fetch Newsletters");
    return null;
  }

}
