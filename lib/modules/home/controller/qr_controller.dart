import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';

var dio = Dio();

scanQrResult(context,String qrResult)async{
  try{
    bool check = await InternetService.checkConnectivity();
    if(check){
      var response = await dio.post(APIS.SCAN_QR,data: {
        "qrcode":qrResult
      });
      if(response.statusCode == 200){
        if(response.data["responseStatus"]=="failed"){
          showToast(context, response.data["message"]);
        }
        else{
          showToast(context, "Successfully scanned.");
        }
        print(response.data);
      }
    }
    else{
      showNoInternetSnackBar(context);
    }
  }
  on DioError catch(e){
    showToast(context, "Unable to process your request now");
  }
}