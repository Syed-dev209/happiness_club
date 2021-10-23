import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({Key? key}) : super(key: key);

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
              image: AssetImage(Images.CATEGORIES_BG), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Automotive",
            style: FontStyle.PoppinsStyle(17, Colors.white,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "25 Offers",
            style: FontStyle.PoppinsStyle(14, Color(ColorCodes.GOLDEN_COLOR)),
          )
        ],
      ),
    );
  }
}
