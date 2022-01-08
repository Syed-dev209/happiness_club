import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.maybePop(context);
            },
              child: SizedBox(
                width: 20,
                  child: SvgPicture.asset(Images.BACK_BUTTON))),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Expanded(
            child: Text(
              title,
              style: FontStyle.PoppinsStyle(17, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
