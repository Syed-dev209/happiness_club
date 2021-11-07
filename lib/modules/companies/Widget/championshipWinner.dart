import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class ChampionshipWinnerCard extends StatelessWidget {
  const ChampionshipWinnerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 199,
      width: 212,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorCodes.LIGHT_GREY_COLOR),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageCircle(),
            SizedBox(height: 8,),
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text("Chris Evans",style: FontStyle.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),),
                 SizedBox(width: 8,),
                 SvgPicture.asset(Images.FIRST_POSITION,height: 20,width: 20,)
              ],
            ),
            SizedBox(height: 8,),
            Text("Laser Tag",style: FontStyle.PoppinsStyle(14, Color(ColorCodes.BLUE_COLOR),fontWeight: FontWeight.w500,)),
          SizedBox(height: 8,),
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.CALENDER_ICON,height: 19,),
               SizedBox(width: 8,),
              Text("26 July, 2021",style: FontStyle.PoppinsStyle(14,Color(ColorCodes.GOLDEN_COLOR),fontWeight: FontWeight.w600 ),)
            ],
          )
          ],
        ),
      ),
    );
  }

  imageCircle() {
    return Container(
      height: 78,
      width: 80,
      child: Stack(
        children: [
          Container(
            height: 73,
            width: 73,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(Images.CATEGORIES_BG),
                    fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: DottedBorder(
                strokeWidth: 3,
                padding: EdgeInsets.zero,
                borderType: BorderType.Circle,
                radius: Radius.circular(40),
                color: Color(ColorCodes.GOLDEN_COLOR),
                child: Container(
                  height: 28.89,
                  width: 28.89,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "1",
                      style: FontStyle.PoppinsStyle(
                          16, Color(ColorCodes.GOLDEN_COLOR),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
