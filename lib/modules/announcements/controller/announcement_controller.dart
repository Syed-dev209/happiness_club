import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/announcements/Model/announcement_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';


var dio = Dio(BaseOptions(
    headers: APIS.HEADER
));
var storage = StorageServices();


Future<AnnouncementModel?> getAnnouncements()async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.ANNOUNCEMENTS);
      if(response.statusCode == 200) {
        AnnouncementModel model = AnnouncementModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.ANNOUNCEMENTS, model.toJson());
        return model;
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.ANNOUNCEMENTS);
      if(response!=""){
        AnnouncementModel model = AnnouncementModel.fromJson(response);
        return model;
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

Future<AnnouncementModelData?> getAnnouncementsById(String id)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.ANNOUNCEMENT,queryParameters: {
        "aid":id
      });
      if(response.statusCode == 200) {
        AnnouncementModelData model = AnnouncementModelData.fromJson(response.data['data']);
        storage.writeDataToStorage(StorageKeys.ANNOUNCEMENTS+"id", model.toJson());
        return model;
      }
    }
    else{
      var response = storage.readDataFromStorage(StorageKeys.ANNOUNCEMENTS+"id");
      if(response!=""){
        AnnouncementModelData model = AnnouncementModelData.fromJson(response);
        return model;
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