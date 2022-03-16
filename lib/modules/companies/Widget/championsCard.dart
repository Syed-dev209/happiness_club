import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';

import '../Model/comapnies_details_model.dart';


class ChampionCard extends StatelessWidget {
  CompanyDetailsModelDataChampions model;
  ChampionCard({  required this.model}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 165,
      decoration: BoxDecoration(
        color: ColorCodes.LIGHT_GREY_COLOR,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 63,
              width: 63,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: CachedNetworkImageProvider(model.photo??Constants.NOT_FOUND_IMAGE_URL),
                //   fit: BoxFit.cover
                // )
              ),
              child: ClipOval(
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: model.photo??Constants.NOT_FOUND_IMAGE_URL,
                    errorWidget: (a,d,f){
                      return CachedNetworkImage(
                        imageUrl: Constants.NOT_FOUND_IMAGE_URL,
                        fit: BoxFit.cover,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("${model.fullName}",style: FontStyles.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}