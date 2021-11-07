import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';


class LuckyDrawWinnerCard extends StatelessWidget {
  const LuckyDrawWinnerCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151,
      width: 161,
      decoration: BoxDecoration(
        color: ColorCodes.LIGHT_GREY_COLOR,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              height: 63,
              width: 63,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Images.CATEGORIES_BG),
                  fit: BoxFit.cover
                  )
              ),
            ),

            SizedBox(height: 8,),
            Text("Tom Holland",style: FontStyle.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),),
              SizedBox(height: 8,),
              Text('T-Shirt',style: FontStyle.PoppinsStyle(14, ColorCodes.DARK_GREY_COLOR,fontWeight: FontWeight.w500),)
          ]
        ),
      ),
    );
  }
}