import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/modules/auth/Controller/auth_controller.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
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
  String selectedType = "Enquiry";
  List<String> selectedList = ["Enquiry","Suggestion","Report an issue","Digital card issue"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    registerButton = CustomFullWidthButton(
        title: "Send",
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
                  title: "Customer Information is required",
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
                      PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)', errorText: "Please enter a valid mobile number")
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
                    controller: companyName,
                    labelText: "Company Name",
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    validator:
                    MultiValidator([
                      RequiredValidator(errorText: "Company name is required*"),
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
                    labelText: "Message",
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    validator:
                    MultiValidator([
                      RequiredValidator(errorText: "Message is required*"),
                    ])
                ),
                SizedBox(
                  height: 15,
                ),
                // CustomFullWidthButton(
                //     title: "Register",
                //   onTap: () {
                //   if(formKey.currentState!.validate()){
                //     addCustomer(context, widget.qrResult, name.text, email.text, phoneNumber.text, companyName.text).then((value) {
                //
                //     });
                //   }
                // }),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  child: buttonWidget,
                ),
                SizedBox(
                  height: 20,
                ),
                // SocialLoginFooter(
                //     onApplePressed: () {},
                //     onFacebookPressed: () {},
                //     onGoogle: () {},
                //     onTwitterPressed: () {})
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
