import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/offers/Screens/offers_by_category_screen.dart';

class CategoriesCard extends StatelessWidget {
  OffersCategoriesModelData modelData;

  CategoriesCard({required this.modelData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>OffersByCategoryScreen(catId: modelData.id.toString(), catName: modelData.categoryName!)));
      },
      child: Container(
        height: 80,
        width: 165,
        //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            // image: DecorationImage(
            //     image: CachedNetworkImageProvider(
            //         modelData.imageFilename ??
            //         Constants.NOT_FOUND_IMAGE_URL,
            //       errorListener: (){
            //            Icon(Icons.error);
            //       }
            //     ),
            //     fit: BoxFit.cover)
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: CachedNetworkImage(
                  height:modelData.imageFilename==null ?100: 200,
                  width: double.maxFinite,
                  imageUrl:modelData.imageFilename ??  Constants.NOT_FOUND_IMAGE_URL,fit: modelData.imageFilename==null ?BoxFit.contain:BoxFit.cover,
                  errorWidget: (context,am,s){
                  return Center(child: Image.asset(Images.NO_IMAGE,fit: BoxFit.contain,height: 100,));
                }, ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${modelData.categoryName}",
                    // style: FontStyle.PoppinsStyle(17, modelData.imageFilename==null?Colors.black:Colors.white,
                    //     fontWeight: FontWeight.w600),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color:  modelData.imageFilename==null?Colors.black:Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0,2),
                          color: Colors.black,
                          blurRadius: 3,
                        )
                      ]
                    ),
                  ),
                  Text(
                    "${modelData.offersCount} Offers",
                   // style: FontStyle.PoppinsStyle(14, Color(ColorCodes.GOLDEN_COLOR)),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(ColorCodes.GOLDEN_COLOR),
                      shadows: [
                        Shadow(
                          offset: Offset(0,2),
                          color: Colors.black,
                          blurRadius: 3,
                        )
                      ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
