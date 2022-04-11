import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/modules/auth/Controller/auth_controller.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/custom_text_field.dart';
import 'package:happiness_club/widgets/snackBars.dart';

import 'otp_screen.dart';

class InputCustomerInfo extends StatefulWidget {
  String qrResult;
  InputCustomerInfo({required this.qrResult});

  @override
  _InputCustomerInfoState createState() => _InputCustomerInfoState();
}

class _InputCustomerInfoState extends State<InputCustomerInfo> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController companyName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget? buttonWidget;
  Widget? registerButton;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    registerButton = CustomFullWidthButton(
        title: LocaleKeys.register.tr(),
        onTap: () {
          if(formKey.currentState!.validate()){
            setState(() {
              buttonWidget = getLoader();
            });
            addCustomer(context, widget.qrResult, name.text, email.text, phoneNumber.text, companyName.text).then((value) {
              if(value == null){
                setState(() {
                  buttonWidget = registerButton;
                });
              }
            });
          }
        });
    buttonWidget = registerButton;

  }
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
              children: [AuthHeaderWidget(title: LocaleKeys.customer_info_required.tr(),showText: false,), signupForm()],
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
                  labelText: LocaleKeys.full_name,
                  keyboardType: TextInputType.name,
                  validator:
                  MultiValidator([
                    RequiredValidator(errorText: LocaleKeys.name_required.tr())
                  ])

              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: phoneNumber,
                  labelText: LocaleKeys.phone_num.tr(),
                  keyboardType: TextInputType.number,
                  validator:
                  MultiValidator([
                    RequiredValidator(errorText: LocaleKeys.phone_num_required.tr()),
                    PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: "Please enter a valid mobile number")
                  ])
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: email,
                  labelText: LocaleKeys.email.tr(),
                  keyboardType: TextInputType.emailAddress,
                  validator:
                  MultiValidator([
                    RequiredValidator(errorText: LocaleKeys.email_required.tr()),
                    EmailValidator(errorText: "Please enter a correct email address")
                  ])
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: companyName,
                  labelText: LocaleKeys.company_name.tr(),
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator:
                  MultiValidator([
                    RequiredValidator(errorText: LocaleKeys.company_name_required.tr()),
                  ])
              ),
              SizedBox(
                height: 15,
              ),
              AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                child: buttonWidget,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
    );
  }

}
