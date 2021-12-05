import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
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
            child: Column(
              children: [
                CustomAppBar(title: "Contact Us"),
                SizedBox(height: 20,),
                fullNameTextField(),
                SizedBox(height: 20,),
                emailTextField(),
                SizedBox(height: 16,),
                phoneTextField(),
                SizedBox(height: 16,),
                messageTextField(),
                SizedBox(height: size.height*0.18,),
                submitButton()
              ],
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
        onPressed: (){},
        child: Text("Submit Message",style: FontStyle.PoppinsStyle(16, Colors.white,fontWeight: FontWeight.w600),),
      ),
    );
  }

  fullNameTextField(){
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: TextFormField(
        controller: fullName,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: "Full Name",
            labelStyle: FontStyle.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  emailTextField(){
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
            labelStyle: FontStyle.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  phoneTextField(){
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: TextFormField(
        controller: phoneNumber,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            labelText: "Phone Number",
          labelStyle: FontStyle.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
        ),
      ),
    );
  }

  messageTextField(){
    return TextFormField(
      maxLines: 5,
      controller: message,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Message Here",
          labelStyle: FontStyle.PoppinsStyle(13, Colors.black26,fontWeight: FontWeight.w300)
      ),
    );
  }
}
