import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/auth/Controller/auth_controller.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/help_customer_screen.dart';
import 'package:happiness_club/modules/auth/Screens/uae_pass_login_screen.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
import 'package:happiness_club/modules/auth/widgets/social_login_footer.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/custom_text_field.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:provider/provider.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({Key? key}) : super(key: key);

  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var maskFormatter;
  bool loading = false;
  int groupVal = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maskFormatter = new MaskTextInputFormatter(
        mask:'+(###) ##-###-####',
        filter: {"#": RegExp(r'[0-9]')},
        initialText: "+(971) 58 123 4567");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AuthHeaderWidget(
                  title: LocaleKeys.login.tr(),
                ),
                formWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  formWidget() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            CustomTextField(
              controller: phoneNumber,
              labelText: "+(971) 58 123 4567",
              keyboardType: TextInputType.phone,
              validator: MultiValidator([
                RequiredValidator(
                    errorText: LocaleKeys.phone_num_required.tr()),
              ]),
              inputFormatters: [maskFormatter],
            ),

            SizedBox(
              height: 18,
            ),
            // rememberMeRow(),
            SizedBox(
              height: 18,
            ),
            !loading
                ? CustomFullWidthButton(
                    title: LocaleKeys.login_to_my_account.tr(),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        loginWithPhoneNumber(
                            context: context,
                            phoneNumber: maskFormatter.getUnmaskedText());
                        //print(maskFormatter.getUnmaskedText());
                      }
                    })
                : Center(child: loader()),
            SizedBox(
              height: 18,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UaePassLoginScreen()));
                },
                child: SvgPicture.asset(Images.UAE_LOGIN_ICON)),
            SizedBox(
              height: 20,
            ),
            // SocialLoginFooter(onApplePressed: (){}, onFacebookPressed:(){}, onGoogle: (){}, onTwitterPressed: (){},signup: false,),
            SizedBox(
              height: 10,
            ),
            helpRow()
          ],
        ),
      ),
    );
  }

  loader() {
    return Platform.isAndroid
        ? CircularProgressIndicator()
        : CupertinoActivityIndicator();
  }

  rememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        radioButton(),
        Text(
          LocaleKeys.forget_password.tr(),
          style: FontStyles.PoppinsStyle(15, Colors.black,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  radioButton() {
    return Container(
      child: Row(
        children: [
          Radio(
              toggleable: true,
              value: 0,
              groupValue: groupVal,
              onChanged: (val) {
                setState(() {
                  if (groupVal < 0) {
                    groupVal = val as int;
                  } else {
                    groupVal = -1;
                  }
                });
              }),
          Text(
            LocaleKeys.remember_me.tr(),
            style: FontStyles.PoppinsStyle(14, Color(ColorCodes.GREY_COLOR),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  helpRow() {
    return RichText(
        text: TextSpan(
            text: LocaleKeys.need_help.tr(),
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.none,
                color: Colors.black),
            children: [
          TextSpan(
            text: LocaleKeys.contact_us.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //  if(signup!){
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => HelpCustomerScreen()));
                // }
              },
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: Color(ColorCodes.GOLDEN_COLOR)),
          )
        ]));
  }
}
