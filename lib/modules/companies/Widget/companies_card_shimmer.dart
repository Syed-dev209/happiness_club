import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:shimmer/shimmer.dart';

class CompaniesCardShimmer extends StatelessWidget {
  const CompaniesCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
        width: 65,
        child: Shimmer.fromColors(
          highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
          baseColor:  ColorCodes.SHIMMER_BASE_COLOR,
          child: Container(
            height: 50,
            width: 65,
            decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          ),
        ));
  }
}
