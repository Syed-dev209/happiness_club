import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/favourites/Widget/remove_from_fav_alert.dart';
import 'package:happiness_club/modules/favourites/model/favorites_model.dart';



class FavouritesCard extends StatelessWidget {
  FavoritesModelData modelData;
  Function reload;
  FavouritesCard({required this.modelData, required this.reload});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 11,vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          imageWidget(),
          SizedBox(width: 15,),
          descriptionWidget(),
          GestureDetector(
            onTap: (){
              showRemoveFromFavoritesAlert(context,modelData.id.toString(),reload);
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,2),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2
                  )
                ],
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Center(
                child: Image.asset(Images.LIKE_ICON_FILLED,height: 15,),
              ),
            ),
          )
        ],
      ),
    );
  }
  imageWidget(){
    return SizedBox(
      height: 75,
      width: 84,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(modelData.featuredImage!,errorBuilder: (context,e,q){
              return Icon(Icons.error);
            },),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 31.64,
              width: 45.76,
              child: Stack(
                children: [
                  SvgPicture.asset(Images.DISCOUNT_FLAG),
                  Align(
                    alignment: Alignment.center,
                      child: Text("${modelData.offerDiscount}",style: FontStyles.PoppinsStyle(10, Colors.white,fontWeight: FontWeight.w500),))
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  descriptionWidget(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${modelData.categoryName}",
            style: FontStyles.PoppinsStyle(
                11, Color(ColorCodes.GREEN_COLOR),
                fontWeight: FontWeight.w600),
          ),
          // SizedBox(
          //   height: 3,
          // ),
          Expanded(
            child: Text(
              "${modelData.title}",
              style: FontStyles.PoppinsStyle(14, Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          locationRow(),
          ratingAndTime()
        ],
      ),
    );
  }

  locationRow() {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(Images.LOCATION_ICON),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: AutoSizeText('${modelData.stateName}',
              style: FontStyles.PoppinsStyle(
                11.5,
                Colors.black26,
              ),minFontSize: 8,maxLines: 2,),
          )
        ],
      ),
    );
  }

  ratingAndTime() {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 60,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LIGHT_PINK_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "9 days left",
                style: FontStyles.PoppinsStyle(
                    10, Color(ColorCodes.DARK_PINK_COLOR),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            // height: 20,
            width: 38,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LITE_YELLOW_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.STAR_ICON),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${modelData.ratings}",
                  style: FontStyles.PoppinsStyle(10, Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
