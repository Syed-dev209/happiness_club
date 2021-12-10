import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';


class CustomFullWidthButton extends StatelessWidget {
  Function onTap;
  String title;
   CustomFullWidthButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(ColorCodes.GOLDEN_COLOR),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: (){
          onTap();
        },
        child: Text(title,style: FontStyle.PoppinsStyle(16, Colors.white,fontWeight: FontWeight.w600),),
      ),
    );
  }
}
