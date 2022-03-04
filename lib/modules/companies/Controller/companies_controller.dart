import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/companies/Model/companies_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';

import '../Model/comapnies_details_model.dart';


var dio = Dio();
var storage = StorageServices();


Future<CompaniesModel?> getAllCompanies(context)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.COMPANIES);
      if(response.statusCode == 200){
        CompaniesModel model = CompaniesModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.COMPANIES, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage(StorageKeys.COMPANIES);
      if(response!=""){
        return CompaniesModel.fromJson(response);
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


Future<CompanyDetailsModel?> getCompanyDetails(context, String companyId)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.get(APIS.COMPANIES_DETAIL,queryParameters: {
        "company_id":companyId
      });
      if(response.statusCode==200){
        CompanyDetailsModel model = CompanyDetailsModel.fromJson(response.data);
        storage.writeDataToStorage(StorageKeys.COMPANIES_DETAIL+companyId, model.toJson());
        return model;
      }
      else{
        return null;
      }
    }
    else{
      showNoInternetSnackBar(context);
      var response = storage.readDataFromStorage(StorageKeys.COMPANIES_DETAIL+companyId);
      if(response!=""){
        return CompanyDetailsModel.fromJson(response);
      }
      else{
        return null;
      }
    }
  }
  on DioError catch(e){
    //print(e);
    showToast(context, "Something went wrong. Please try again later");
    return null;
  }

}