import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';

import '../Model/comapnies_details_model.dart';


class LuckyDrawWinnerCard extends StatelessWidget {
  CompanyDetailsModelDataLuckyWinners model;
  LuckyDrawWinnerCard({required this.model});

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
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: model.photo==null||model.photo==""? Constants.ALT_IMAGE:model.photo!,
                  errorWidget: (s,a,c){
                    return Center(
                      child: CachedNetworkImage(imageUrl: Constants.ALT_IMAGE,),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 8,),
            Text("${model.fullName}",style: FontStyles.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),),
              SizedBox(height: 8,),
              Text('${model.giftTitle}',style: FontStyles.PoppinsStyle(14, ColorCodes.DARK_GREY_COLOR,fontWeight: FontWeight.w500),)
          ]
        ),
      ),
    );
  }
}