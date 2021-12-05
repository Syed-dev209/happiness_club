import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:shimmer/shimmer.dart';


class DealShimmerCard extends StatelessWidget {
 bool? smallCard;
 DealShimmerCard({@required this.smallCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallCard!?220:260,
      width: smallCard! ? 161 : 230,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            width: double.maxFinite,
            child: Shimmer.fromColors(
                child: Container(
                  height: 130,
                  width: double.maxFinite,

                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14)
                  ),
                ),
                baseColor: ColorCodes.SHIMMER_BASE_COLOR,
                highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR
            ),
          ),
          SizedBox(height: 12,),
          SizedBox(
            height: 15,
            width: double.maxFinite,
            child: Shimmer.fromColors(
                child: Container(
                  height: 30,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14)
                  ),
                ),
                baseColor: ColorCodes.SHIMMER_BASE_COLOR,
                highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR
            ),
          ),
          SizedBox(height: 12,),
          SizedBox(
            height: 18,
            width: double.maxFinite,
            child: Shimmer.fromColors(
                child: Container(
                  height: 18,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(14)
                  ),
                ),
                baseColor: ColorCodes.SHIMMER_BASE_COLOR,
                highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR
            ),
          ),
        ],
      ),
    );
  }
}
