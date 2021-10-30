import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';



class PartnersCard extends StatelessWidget {
  const PartnersCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(Images.CATEGORIES_BG),
          fit: BoxFit.cover
        )
      ),
    );
  }
}