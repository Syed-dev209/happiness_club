import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:shimmer/shimmer.dart';


class NewsletterShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.maxFinite,
      child: Shimmer.fromColors(
        highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
        baseColor: ColorCodes.SHIMMER_BASE_COLOR,
        child: Container(
          height: 220,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
