import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';


class AuthHeaderWidget extends StatelessWidget {
  String title;
  AuthHeaderWidget({required this.title}) ;

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
                  //SizedBox(height: 18,),
                  Text("$title",style: FontStyle.PoppinsStyle(20, Colors.black,fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  Text("Welcome! $title to continue!",style: FontStyle.PoppinsStyle(12, ColorCodes.DARK_GREY_COLOR,fontWeight: FontWeight.w300),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}