import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:blur/blur.dart';

class OffersSummary extends StatefulWidget {
  const OffersSummary({Key? key}) : super(key: key);

  @override
  _OffersSummaryState createState() => _OffersSummaryState();
}

class _OffersSummaryState extends State<OffersSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Restaurants",
                          style: FontStyle.PoppinsStyle(
                              14, Color(ColorCodes.BLUE_COLOR),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Mc Donald Burger Deal",
                          style: FontStyle.PoppinsStyle(16, Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        locationRow(),
                        SizedBox(
                          height: 3,
                        ),
                        ratingAndTime(),
                      ]),
                  Container(
                    height: 28,
                    width: 65,
                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.black
                    ),
                  ).blurred(
                      //blur: 1,
                      blurColor: Color(ColorCodes.GOLDEN_COLOR),
                      colorOpacity: 0.2,
                      borderRadius: BorderRadius.circular(20),
                      overlay: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              Images.DIRECTION_ICON,
                              color: Color(ColorCodes.GOLDEN_COLOR),
                            ),
                            Text(
                              '4.5km',
                              style: FontStyle.PoppinsStyle(
                                  11, Color(ColorCodes.GOLDEN_COLOR)),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Details",
              style: FontStyle.PoppinsStyle(20, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10,),
            Text(
              "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and "
              "demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the"
              " pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty"
              " through weakness of will, which is the same as saying through shrinking from toil and pain."
              " These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is "
              "untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be"
              " welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the "
              "obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted."
              " The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures "
              "to secure other greater pleasures, or else he endures pains to avoid worse pains.",
              style: FontStyle.PoppinsStyle(12, Colors.black.withOpacity(0.7)),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Color(
                            ColorCodes.GOLDEN_COLOR,
                          ),
                          width: 2)),
                  child: Image.asset(
              
                    Images.LIKE_ICON3,
                    cacheHeight: 25,
                    filterQuality: FilterQuality.high,
                    // width: 10,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: () {},
                    child: Text("Report a problem",style: FontStyle.PoppinsStyle(17, Colors.white),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  locationRow() {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(Images.LOCATION_ICON),
          SizedBox(
            width: 10,
          ),
          Text('Zar Mall, Dubai',
              style: FontStyle.PoppinsStyle(
                14,
                Colors.black26,
              ))
        ],
      ),
    );
  }

  ratingAndTime() {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 68,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LIGHT_PINK_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "9 days left",
                style: FontStyle.PoppinsStyle(
                    11, Color(ColorCodes.DARK_PINK_COLOR),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            // height: 20,
            width: 42,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LITE_YELLOW_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.STAR_ICON),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "4.2",
                  style: FontStyle.PoppinsStyle(11, Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
