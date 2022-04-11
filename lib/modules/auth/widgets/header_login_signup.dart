  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';


class AuthHeaderWidget extends StatelessWidget {
  String title;
  bool showText= true;
  AuthHeaderWidget({required this.title,this.showText=true}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.375,
      width: double.maxFinite,
      //color: Colors.black,
      child: Stack(
        children: [
          SvgPicture.asset(Images.SPLASH_BG,fit: BoxFit.fitWidth,),
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 12),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: SvgPicture.asset(Images.BACK_BUTTON)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(child: Image.asset(Images.LOGO,height: 130,)),
                  showText? Text("$title",style: FontStyles.PoppinsStyle(20, Colors.black,fontWeight: FontWeight.w600),):Text(""),
                  SizedBox(height: 10,),
                  showText? Text("${LocaleKeys.welcome.tr()} $title ${LocaleKeys.to_continue.tr()}",style: FontStyles.PoppinsStyle(12, ColorCodes.DARK_GREY_COLOR,fontWeight: FontWeight.w300),):Text("")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
