import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => HomeBase()));
    });
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
