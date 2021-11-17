import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';


class DigitalCardWidget extends StatelessWidget {
  const DigitalCardWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(Images.CREDIT_CARD),
          fit: BoxFit.cover
          )
      ),
    );
  }
}