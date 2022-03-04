import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';

import '../Model/comapnies_details_model.dart';

class ChampionshipWinnerCard extends StatelessWidget {
  CompanyDetailsModelDataChampionshipWinners model;
  ChampionshipWinnerCard({required this.model});

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
                 Text("${model.fullName}",style: FontStyle.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),),
                 SizedBox(width: 8,),
                 SvgPicture.asset(
                   model.position==1?
                   Images.FIRST_POSITION:
                   model.position==2?
                   Images.SECOND_POSITION:
                   Images.THIRD_POSITION,

                   height: 20,width: 20,)
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
               ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: model.photo??Constants.ALT_IMAGE,
                errorWidget: (a,s,f){
                  return Center(
                    child: CachedNetworkImage(imageUrl: Constants.ALT_IMAGE,fit: BoxFit.cover,),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
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
                      "${model.position}",
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
