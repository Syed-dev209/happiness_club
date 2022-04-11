import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/contactUs/contact_us_controller.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';


class ContactUsScreen extends StatefulWidget {

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomAppBar(title: LocaleKeys.contact_us.tr()),
                  SizedBox(height: 20,),
                  fullNameTextField(),
                  SizedBox(height: 20,),
                  emailTextField(),
                  SizedBox(height: 16,),
                  phoneTextField(),
                  SizedBox(height: 16,),
                  messageTextField(),
                  SizedBox(height: size.height*0.12,),
                  submitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitButton(){
    return SizedBox(
      height: 52,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        onPressed: (){
          if(formKey.currentState!.validate()) {
            postMessage(context, fullName.text, email.text, message.text).then((
                value) {
              fullName.clear();
              email.clear();
              phoneNumber.clear();
              message.clear();
            });
          }
        },
        child: Text(LocaleKeys.submit_msg.tr(),style: FontStyles.PoppinsStyle(16, Colors.white,fontWeight: FontWeight.w600),),
      ),
    );
  }

  fullNameTextField(){
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: TextFormField(
        controller: fullName,
        validator: MultiValidator([
          RequiredValidator(errorText: LocaleKeys.name_required.tr())
        ]),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: LocaleKeys.full_name.tr(),
            labelStyle: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  emailTextField(){
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: TextFormField(
        controller: email,
        validator: MultiValidator([
          RequiredValidator(errorText: LocaleKeys.email_required.tr()),
          EmailValidator(errorText: "Enter a valid email")
        ]),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: LocaleKeys.email.tr(),
            labelStyle: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  phoneTextField(){
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: TextFormField(
        controller: phoneNumber,
        validator: MultiValidator([
          RequiredValidator(errorText: LocaleKeys.phone_num_required.tr()),
          PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: "Please enter a valid mobile number")
        ]),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            labelText: LocaleKeys.phone_num.tr(),
          labelStyle: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  messageTextField(){
    return TextFormField(
      maxLines: 5,
      controller: message,
      validator: MultiValidator([
        RequiredValidator(errorText: LocaleKeys.message_required.tr())
      ]),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: LocaleKeys.message.tr(),
          labelStyle: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
      ),
    );
  }
}
