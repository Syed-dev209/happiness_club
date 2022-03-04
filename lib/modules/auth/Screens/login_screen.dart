import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/auth/widgets/header_login_signup.dart';
import 'package:happiness_club/modules/auth/widgets/social_login_footer.dart';
import 'package:happiness_club/widgets/custom_full_width_button.dart';
import 'package:happiness_club/widgets/custom_text_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int groupVal = -1;
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
                AuthHeaderWidget(title: "Login",),
                formWidget(),

              ],
            ),
          ),
        ),
      ),
    );
  }

    formWidget(){
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              CustomTextField(
                controller: email,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator:
                  MultiValidator([
                    RequiredValidator(errorText: "Email required*"),
                    EmailValidator(errorText: "Please enter a correct email address")
                  ]),
              ),
              SizedBox(height: 15,),
              CustomTextField(
                controller: pass,
                labelText: "Password",
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator:
                  MultiValidator([
                    RequiredValidator(errorText: "Password is required*"),
                    PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', errorText: "You must enter one uppercase, one lower case, one digit and one symbol")
                  ]),
              ),
              SizedBox(height: 18,),
              rememberMeRow(),
              SizedBox(height: 18,),
              CustomFullWidthButton(title: "Login to my Account", onTap: (){
                if(formKey.currentState!.validate()){
                  //print("pappu");
                }
              }),
              SizedBox(
                height: 20,
              ),
              SocialLoginFooter(onApplePressed: (){}, onFacebookPressed:(){}, onGoogle: (){}, onTwitterPressed: (){},signup: false,)
            ],
          ),
        ),
      );
    }

    rememberMeRow(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          radioButton(),
          Text("Forget Password?",style: FontStyle.PoppinsStyle(15, Colors.black,fontWeight: FontWeight.w400),)
        ],
      );
    }

    radioButton(){
      return Container(
        child: Row(
          children: [
            Radio(
              toggleable: true,
                value: 0,
                groupValue: groupVal,
                onChanged: (val){
              setState(() {
                if(groupVal < 0){
                  groupVal = val as int;
                }
                else{
                  groupVal = -1;
                }
              });
            }),
            Text("Remember me",style: FontStyle.PoppinsStyle(14, Color(ColorCodes.GREY_COLOR),fontWeight: FontWeight.w400),)
          ],
        ),
      );
    }
}
