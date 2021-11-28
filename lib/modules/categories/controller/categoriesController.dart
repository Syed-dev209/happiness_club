import 'package:dio/dio.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/services/internet_service.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

var dio = Dio();
var storage = StorageServices();

Future getOfferCategories(context) async {
  try {
    bool check = await InternetService.checkConnectivity();
    if (check) {

      var response = await dio.get(APIS.OFFER_CATEGORIES);
      if (response.statusCode == 200) {
        var model = OffersCategoriesModel.fromJson(response.data);
        Provider.of<CategoriesOfferProvider>(context, listen: false)
            .addModel(model);
        storage.writeDataToStorage(StorageKeys.CATEGORIES, model.toJson());
      }
    } else {
      showNoInternetSnackBar(context);
      var data = storage.readDataFromStorage(StorageKeys.CATEGORIES);
      if (data != "") {
        var model = OffersCategoriesModel.fromJson(data);
        Provider.of<CategoriesOfferProvider>(context, listen: false)
            .addModel(model);
      }
    }
  } on DioError catch (e) {
    print("Fail to load categories from API");
  }
}
