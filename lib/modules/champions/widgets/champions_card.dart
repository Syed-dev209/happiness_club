import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';


class ChampionsCard extends StatelessWidget {
  const ChampionsCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
       
        color: ColorCodes.WHITE_COLOR,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children:[
          Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
               boxShadow: [
          BoxShadow(
            offset: Offset(0,1),
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.2)
          )
        ],
              shape: BoxShape.circle,
              border: Border.all(color: ColorCodes.WHITE_COLOR),
              image: DecorationImage(
                image: AssetImage(Images.DEAL_BG),
                fit: BoxFit.cover
              )
            ),
          ),

          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Black Adam',style: FontStyle.PoppinsStyle(16, Colors.black,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text('Champion',style: FontStyle.PoppinsStyle(12, Color(ColorCodes.GOLDEN_COLOR),fontWeight: FontWeight.w600),)
            ],
          )
        ]
      ),
    );
  }
}