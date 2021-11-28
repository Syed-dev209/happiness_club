import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/categories/controller/categoriesController.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';
import 'package:happiness_club/modules/home/controller/homeController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  loadData()async{
    await getOfferCategories(context);
    await getSliderImages(context);
    await getMostViewedOffers(context);
    await getLatestOffers(context);
    await getFeaturedOffers(context);
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => HomeBase()));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(Images.SPLASH_BG),
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
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Loading...",
                              style: FontStyle.PoppinsStyle(14, Colors.black,
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
