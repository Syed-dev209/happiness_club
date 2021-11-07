import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';


class ChampionCard extends StatelessWidget {
  const ChampionCard({ Key? key }) : super(key: key);

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
                image: DecorationImage(
                  image: AssetImage(Images.DEAL_BG),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 10,),
            Text("John Smith",style: FontStyle.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}