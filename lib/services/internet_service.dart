import 'package:connectivity/connectivity.dart';

class InternetService {
  static InternetService _internetServices = InternetService._internal();
  factory InternetService() {
    return _internetServices;
  }
  InternetService._internal();

  static Future<bool> checkConnectivity() async {
    var connection = await (Connectivity().checkConnectivity());
    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
