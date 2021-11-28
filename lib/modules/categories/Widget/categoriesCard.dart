import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';

class CategoriesCard extends StatelessWidget {
  OffersCategoriesModelData modelData;
  CategoriesCard({required this.modelData});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 165,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: CachedNetworkImageProvider(modelData.imageFilename??"https://hpc.softlinks.ae/public/storage/offer_categories/Limited_Offer.png"), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${modelData.categoryName}",
            style: FontStyle.PoppinsStyle(17, Colors.white,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "${modelData.offersCount} Offers",
            style: FontStyle.PoppinsStyle(14, Color(ColorCodes.GOLDEN_COLOR)),
          )
        ],
      ),
    );
  }
}
