import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/favourites/model/favorites_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';


var dio = Dio();
var storage = StorageServices();


Future<FavoritesModel?> getFavoritesList(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      final user = Provider.of<UserModelProvider>(context,listen: false).customerId;
      var response = await dio.post(APIS.FAVORITES_LIST,queryParameters: {
        "customer_id":user
      });
      if(response.statusCode == 200){
        print(response.data);
        FavoritesModel model = FavoritesModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.FAVORITES, model.toJson());
        return model;
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage(StorageKeys.FAVORITES);
      if(response!="") {
        return FavoritesModel.fromJson(response);
      }
    }
  }
  on DioError catch(e){
    return null;
  }
}


Future markAsFavorite(context, String offerId)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      final user = Provider.of<UserModelProvider>(context,listen: false);
      if(user.loggedIn){
        var response = await dio.post(APIS.ADD_TO_FAVORITES,queryParameters: {
          "customer_id":user.customerId,
          "offer_id":offerId
        });
        if(response.statusCode == 200){
          showToast(context, response.data["message"]);
        }
      }
      else{
        showToast(context, "You must login to mark favorite.");
      }
    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(e){

  }
}

Future removeFromFavorites(context,String offerId)async{
  try{
    bool check = await InternetService.checkConnectivity();
    final user = Provider.of<UserModelProvider>(context,listen: false).customerId;
    if(check){
      var response = await dio.post(APIS.REMOVE_FAVORITES,queryParameters: {
        "customer_id":user,
        "offer_id":offerId
      });
      if(response.statusCode == 200){
        showToast(context, response.data["message"]);
      }
    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(e){

  }
}