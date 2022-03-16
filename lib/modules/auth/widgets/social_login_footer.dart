import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'dart:io' show Platform;

import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/auth/Screens/login_screen.dart';
import 'package:happiness_club/modules/auth/Screens/signup_screen.dart';
import 'package:happiness_club/modules/termsAndPrivacy/terms_and_privacy_screen.dart';


class SocialLoginFooter extends StatelessWidget {
  bool? signup;
  Function onApplePressed;
  Function onGoogle;
  Function onFacebookPressed;
  Function onTwitterPressed;

  SocialLoginFooter({this.signup=true, required this.onApplePressed, required this.onFacebookPressed, required this.onGoogle, required this.onTwitterPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          dividerLine(),
          SizedBox(height: 25,),
          socialLoginButtons(),
          SizedBox(height: 20,),
          RichText(
              text: TextSpan(
                text: signup! ? "Login":"Signup",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                  if(signup!){
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>LoginScreen()));
                  }
                  else{
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignupScreen()));
                  }

                    },
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Color(ColorCodes.GOLDEN_COLOR)
                ),
                children: [
                  TextSpan(
                    text: signup!?" if already have account":" for new account",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                        color: Colors.black
                    ),
                  )
                ]
              )
          )
        ],
    ),
    );
  }

  dividerLine(){
    return Row(
      children: [
        Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Image.asset(Images.DOTTED_LINE),
            )
        ),
        SizedBox(width: 8,),
        Text("Or ${signup!?"Sign Up":"Login"} with",style: FontStyles.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w400),),
        SizedBox(width: 8,),
        Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Image.asset(Images.DOTTED_LINE),
            )
        ),
      ],
    );
  }

  socialLoginButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        customButtons(Images.APPLE_LOGIN, onApplePressed),
        customButtons(Images.FACEBOOK_LOGIN, onFacebookPressed),
        customButtons(Images.TWITTER_LOGIN, onTwitterPressed),
        customButtons(Images.GOOGLE_LOGIN,onGoogle),
      ],
    );
  }

  customButtons(String imagePath, Function onTap){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 52,
        width: 65,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26,width: 1.5),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Image.asset(imagePath,height: 25,),
        ),
      ),
    );
  }
}
