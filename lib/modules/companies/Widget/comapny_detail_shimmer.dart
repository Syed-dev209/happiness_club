import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colorCodes.dart';


class CompanyDetailShimmer extends StatelessWidget {
  const CompanyDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        SizedBox(
          height: 139,
          width: 139,
          child: Shimmer.fromColors(
            baseColor: ColorCodes.SHIMMER_BASE_COLOR,
            highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
            child: Container(
              height: 139,
              width: 139,
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 10,
          width: double.maxFinite,
          child: Shimmer.fromColors(
              baseColor: ColorCodes.SHIMMER_BASE_COLOR,
              highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
            child: Container(
              height: 10,
              width: double.maxFinite,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
          width: double.maxFinite,
          child: Shimmer.fromColors(
            baseColor: ColorCodes.SHIMMER_BASE_COLOR,
            highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
            child: Container(
              height: 10,
              width: double.maxFinite,
              color: Colors.black,
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Shimmer.fromColors(
          baseColor: ColorCodes.SHIMMER_BASE_COLOR,
          highlightColor:  ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
          child: Container(
            height: 102,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                              color: Colors.black
                          )
                      ),
                      //SizedBox(height: 8,),
                      Expanded(
                          child: Container(
                              color: Colors.black
                          )
                      )
                    ],
                  ),
                ),
                //Image.asset(Images.DOTTED_LINE),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(  color: Colors.black)
                      ),
                      //SizedBox(height: 8,),
                      Expanded(
                          child: Container(  color: Colors.black))
                    ],
                  ),
                ),
                //Image.asset(Images.DOTTED_LINE),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(  color: Colors.black)),
                      //SizedBox(height: 8,),
                      Expanded(
                          child: Container(  color: Colors.black))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
