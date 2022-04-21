import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/modules/auth/Controller/auth_controller.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/custom_text_field.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:happiness_club/constants/fontStyles.dart';



class HelpCustomerScreen extends StatefulWidget {
  const HelpCustomerScreen({Key? key}) : super(key: key);

  @override
  _HelpCustomerScreenState createState() => _HelpCustomerScreenState();
}

class _HelpCustomerScreenState extends State<HelpCustomerScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget? buttonWidget;
  Widget? registerButton;
  String selectedType = LocaleKeys.enquiry.tr();
  List<String> selectedList = [LocaleKeys.enquiry.tr(),LocaleKeys.suggestion.tr(),LocaleKeys.report_a_problem.tr(),LocaleKeys.digital_card_issue.tr()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    registerButton = CustomFullWidthButton(
        title: LocaleKeys.send.tr(),
        onTap: () {
          if(formKey.currentState!.validate()){
            setState(() {
              buttonWidget = getLoader();
            });
           postCustomerHelp(context, message.text, name.text, email.text, phoneNumber.text, companyName.text,selectedType).then((value){
             if(value==null){
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
              children: [
                AuthHeaderWidget(
                  title: LocaleKeys.customer_info_required.tr(),
                  showText: false,
                ),
                signupForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  signupForm() {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
      child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                CustomTextField(
                    controller: name,
                    labelText: LocaleKeys.full_name.tr(),
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
                      PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: LocaleKeys.enter_valid_number.tr())
                    ])
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: email,
                    labelText: LocaleKeys.email,
                    keyboardType: TextInputType.emailAddress,
                    validator:
                    MultiValidator([
                      RequiredValidator(errorText: LocaleKeys.email_required.tr()),
                      EmailValidator(errorText: LocaleKeys.enter_valid_email.tr())
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
                typeDropDown(),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: message,
                    labelText: LocaleKeys.message.tr(),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    validator:
                    MultiValidator([
                      RequiredValidator(errorText: LocaleKeys.message_required.tr()),
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
      ),
    );
  }


  typeDropDown(){
    return DropdownButtonFormField(
      style: FontStyles.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300) ,
      isExpanded: true,
      value: selectedType,
        onChanged: (dynamic val){
        setState(() {
          selectedType = val;
        });
        },
        items: selectedList.map((e) => DropdownMenuItem(value:e,child: Text(e))).toList()
    );
  }
}
