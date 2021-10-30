import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';


class NewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 10),
          foregroundDecoration:BoxDecoration(
             borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent,Colors.black.withOpacity(0.55)]
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(Images.CREDIT_CARD),
              fit: BoxFit.cover
            )
          ),
        ),
        Padding(
      padding: EdgeInsets.only(top: 160,left: 10),
       child: Text('Newsletter / Issue # 4 - Quarter 3,2020',style: FontStyle.PoppinsStyle(18, Colors.white),))
      ],
    );
  }
}