import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:shimmer/shimmer.dart';


class CategoryCardShimmer extends StatefulWidget {
  const CategoryCardShimmer({Key? key}) : super(key: key);

  @override
  _CategoryCardShimmerState createState() => _CategoryCardShimmerState();
}

class _CategoryCardShimmerState extends State<CategoryCardShimmer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 165,
      child: Shimmer.fromColors(
        baseColor: ColorCodes.SHIMMER_BASE_COLOR,
        highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
        child: Container(
          height: 80,
          width: 165,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );

  }

}
