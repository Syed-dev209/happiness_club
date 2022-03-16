import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/categories/controller/categoriesController.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';
import 'package:happiness_club/modules/home/controller/homeController.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/services/notification_services.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var storage = StorageServices();

  Future loadData()async{
    var response = storage.readDataFromStorage(StorageKeys.LOGGED_IN);
    var uid = storage.readDataFromStorage(StorageKeys.USER_ID);
    var name = storage.readDataFromStorage(StorageKeys.USER_NAME);
    var memb = storage.readDataFromStorage(StorageKeys.USER_MEMBERSHIP);
    var exp = storage.readDataFromStorage(StorageKeys.USER_EXP_DATE);
    var company = storage.readDataFromStorage(StorageKeys.USER_COMPANY);
    var access = storage.readDataFromStorage(StorageKeys.USER_ACCESS);
    if(response!="" && uid!="" && name!=""){
      Provider.of<UserModelProvider>(context,listen: false).updateLoginStatus(true);
      Provider.of<UserModelProvider>(context,listen: false).addCustomerId(uid);
      Provider.of<UserModelProvider>(context,listen: false).addName(name);
      Provider.of<UserModelProvider>(context,listen: false).setMembershipDetails(memb, exp);
      Provider.of<UserModelProvider>(context,listen: false).setCompanyName(company);
      Provider.of<UserModelProvider>(context,listen: false).setAccessType(access);
    }
    // await getOfferCategories(context);
    // await getSliderImages(context);
    // getMostViewedOffers(context);
    // getLatestOffers(context);
     await LocationService().getCurrentLocation(context);
    await getDashboardData(context);

    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => HomeBase()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //PushNotificationServices().getDeviceToken();
    PushNotificationServices().requestPermission();
    loadData().then((value) {
      PushNotificationServices().initializeNotifications(context);
    });

  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.98,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorCodes.WHITE_COLOR,
          ),
          child: Center(
              child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(Images.SPLASH_BG,fit: BoxFit.cover,height: size.height,width: size.width,)),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Image.asset(
                          Images.LOGO,
                          // height: 250,
                          // width: 200,
                          cacheHeight: 450,
                          cacheWidth: 600,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Loading...",
                              style: FontStyles.PoppinsStyle(14, Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                width: 220,
                                child: LinearProgressIndicator(
                                  color: Color(ColorCodes.LITE_GOLDEN_COLOR),
                                ))
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
