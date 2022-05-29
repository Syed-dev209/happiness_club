import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Screens/otp_screen.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
import 'package:happiness_club/modules/auth/widgets/social_login_footer.dart';
import 'package:happiness_club/modules/termsAndPrivacy/terms_and_privacy_screen.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool agreement = false;

  get markedTextStyle => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      fontFamily: "Poppins",
      decoration: TextDecoration.underline,
      color: Color(ColorCodes.GOLDEN_COLOR));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [AuthHeaderWidget(title: "Sign up"), signupForm()],
            ),
          ),
        ),
      ),
    );
  }

  signupForm() {
    return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              CustomTextField(
                  controller: name,
                  labelText: "Full Name",
                keyboardType: TextInputType.name,
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: "Name is required*")
                    ])

              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: phoneNumber,
                  labelText: "Phone Number",
                keyboardType: TextInputType.number,
                validator:
                    MultiValidator([
                      RequiredValidator(errorText: "Phone Number is required*"),
                      PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: LocaleKeys.enter_valid_number.tr())
                    ])
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: email,
                  labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator:
                  MultiValidator([
                    RequiredValidator(errorText: "Email required*"),
                    EmailValidator(errorText: "Please enter a correct email address")
                  ])
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: password,
                  labelText: "Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator:
                  MultiValidator([
                    RequiredValidator(errorText: "Password is required*"),
                    PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', errorText: "You must enter one uppercase,\none lower case, one digit and one symbol")
                  ])
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: confirmPassword,
                  labelText: "Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Password is required*"),
                ])
              ),
              SizedBox(
                height: 15,
              ),
              agreementRow(),
              SizedBox(
                height: 25,
              ),
              CustomFullWidthButton(title: "Register", onTap: () {
                if(formKey.currentState!.validate()){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>OtpScreen(token: "",)));
                }
              }),
              SizedBox(
                height: 20,
              ),
              SocialLoginFooter(
                  onApplePressed: () {},
                  onFacebookPressed: () {},
                  onGoogle: () {},
                  onTwitterPressed: () {})
            ],
          ),
        ));
  }

  agreementRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Checkbox(
            side: BorderSide(color: Colors.black26, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: agreement,
            onChanged: (value) {
              setState(() {
                agreement = value!;
              });
            }),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: RichText(
              text: TextSpan(
                  text: "I agree to ",
                  style: FontStyles.PoppinsStyle(14, Colors.black26,
                      fontWeight: FontWeight.w400),
                  children: [
                TextSpan(
                    text: "Terms & Conditions ",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsAndPrivacyScreen(type: Constants.TERMS)));
                      },
                    style: markedTextStyle),
                TextSpan(text: " and ", children: [
                  TextSpan(
                    text: "Privacy Policy",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsAndPrivacyScreen(type: Constants.PRIVACY)));
                      },
                    style: markedTextStyle,
                  )
                ])
              ])),
        )
      ],
    );
  }
}
