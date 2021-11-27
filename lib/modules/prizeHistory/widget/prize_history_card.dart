import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class PrizeHistoryCard extends StatelessWidget {
  const PrizeHistoryCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Container(
            height: 51,
            width: 51,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorCodes.LIGHT_YELLOW_COLOR
            ),
            child: Center(
              child: Container(
                height: 22,
                width: 22,
                child: SvgPicture.asset(
                  Images.TROPHY_ICON,
                  height: 10,
                  width: 10,
                   fit: BoxFit.scaleDown,
                  ),
              ),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Money',style: FontStyle.PoppinsStyle(16, Colors.black,fontWeight: FontWeight.w600),),
                SizedBox(height: 5,),
                Text("Tom Holland",style: FontStyle.PoppinsStyle(14, Colors.black26,fontWeight: FontWeight.w600),)
              ],
            ),
          ),

          Expanded(child: Text("26 July",style: FontStyle.PoppinsStyle(14, Color(ColorCodes.GOLDEN_COLOR),fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
}