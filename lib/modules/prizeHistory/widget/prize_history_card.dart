import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/prizeHistory/model/prize_history_model.dart';

class PrizeHistoryCard extends StatelessWidget {
  PrizeHistoryModelData model;
  PrizeHistoryCard({required this.model});

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
                Text('${model.giftTitle}',style: FontStyles.PoppinsStyle(16, Colors.black,fontWeight: FontWeight.w600),),
                SizedBox(height: 5,),
                Text("${model.fullName}",style: FontStyles.PoppinsStyle(14, Colors.black26,fontWeight: FontWeight.w600),)
              ],
            ),
          ),

          //Expanded(child: Text("26 July",style: FontStyles.PoppinsStyle(14, Color(ColorCodes.GOLDEN_COLOR),fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
}