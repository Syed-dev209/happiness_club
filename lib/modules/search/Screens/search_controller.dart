import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';


var dio = Dio();
var storage = StorageServices();



Future<OffersModel?> searchUserInput(context,String input)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check) {
      var response = await dio.get(APIS.SEARCH,queryParameters: {
        "param":input
      });
      if(response.statusCode == 200 && response.data['responseStatus']=="success"){
        OffersModel model = OffersModel.fromJson(response.data);
        return model;
      }
      else{
        showToast(context, response.data["responseStatus"]);
        return null;
      }
    }
    else{
      showToast(context, "No Internet Connection");
      return null;
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to search. Please try again later.");
    return null;
  }
}