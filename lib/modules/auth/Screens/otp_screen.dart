import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/phone_input_screen.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';
import 'package:happiness_club/modules/home/screens/homeScreen.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


class OtpScreen extends StatefulWidget {
  String otp;
  OtpScreen({required this.otp});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpText=TextEditingController();
  var storage = StorageServices();
  int failCount=0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(),
                SizedBox(height: size.height*0.08,),
                Center(child: Text(LocaleKeys.sign_up.tr(),style: FontStyles.PoppinsStyle(20, Colors.black,fontWeight: FontWeight.w600),)),
                SizedBox(height: 10,),
                Center(
                  child: Text(LocaleKeys.we_have_sent_an_otp_code.tr(),style: FontStyles.PoppinsStyle(14, Colors.black26,fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 60),
                otpFields(),
                SizedBox(height: 20,),
                resendCode(),
                SizedBox(height: size.height*0.1,),
                CustomFullWidthButton(title: LocaleKeys.verify.tr(), onTap: (){
                  if(otpText.text == widget.otp){
                    Provider.of<UserModelProvider>(context,listen: false).updateLoginStatus(true);
                    storage.writeDataToStorage(StorageKeys.LOGGED_IN, "true");
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>HomeBase()));
                    showToast(context, LocaleKeys.welcome_to_hpc.tr());
                  }
                  else{
                    //fail count

                    otpText.clear();
                    failCount = failCount + 1;
                    if(failCount==3){
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>PhoneInputScreen()));
                      showToast(context, LocaleKeys.failed_to_login.tr());
                    }
                    else{
                      showToast(context, LocaleKeys.wrong_password.tr());
                    }
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
  appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: SvgPicture.asset(Images.BACK_BUTTON),
        )
      ],
    );
  }

  otpFields(){
    return PinCodeTextField(
      pinTheme: PinTheme(
        fieldHeight: 69,
        fieldWidth: 62,
        borderRadius: BorderRadius.circular(14),
        borderWidth: 1.5,
        activeColor: Color(ColorCodes.GREY_COLOR),
        selectedColor: Color(ColorCodes.GOLDEN_COLOR),
        inactiveColor: Color(ColorCodes.GREY_COLOR),
        shape: PinCodeFieldShape.box
      ),
        textStyle: FontStyles.PoppinsStyle(32, Colors.black,fontWeight: FontWeight.w700),
        appContext: context,
        controller: otpText,
        keyboardType: TextInputType.number,
        length: 5,
        onChanged: (val){
        }
    );
  }

  resendCode(){
    return RichText(text: TextSpan(
      text: LocaleKeys.havent_receive_code.tr(),
      style: FontStyles.PoppinsStyle(14, Color(ColorCodes.GREY_COLOR),fontWeight: FontWeight.w400),
      children: [
        TextSpan(
          text: LocaleKeys.resend.tr(),
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ColorCodes.GOLDEN_COLOR),
            decoration: TextDecoration.underline
          )
        )
      ]
    ));
  }
}
