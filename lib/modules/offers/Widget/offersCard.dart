import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:blur/blur.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/favourites/controller/favorites_controller.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

class OffersCard extends StatefulWidget {
  OffersModelData modelData;

  OffersCard({required this.modelData});

  @override
  _OffersCardState createState() => _OffersCardState();
}

class _OffersCardState extends State<OffersCard> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => OfferDetailsScreen(
                      offerId: widget.modelData.id.toString(),
                    )));
      },
      child: Container(
        height: 296,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dealImage(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.modelData.categoryName}",
                        style: FontStyle.PoppinsStyle(
                            11, Color(ColorCodes.BLUE_COLOR),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              constraints:
                                  BoxConstraints(minHeight: 0, maxHeight: 20),
                              child: AutoSizeText(
                                "${widget.modelData.title}",
                                style: FontStyle.PoppinsStyle(14, Colors.black,
                                    fontWeight: FontWeight.w500),
                                minFontSize: 9,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                final user = Provider.of<UserModelProvider>(
                                    context,
                                    listen: false);
                                if (user.loggedIn) {
                                  setState(() {
                                    like = !like;
                                  });
                                  markAsFavorite(
                                      context, widget.modelData.id.toString()).then((value) {
                                        print(value);
                                        if(value != "success"){
                                          setState(() {
                                            like =!like;
                                          });
                                        }
                                  });
                                }
                                else{
                                  showToast(context, "You must login to mark favorite.");
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.black.withOpacity(0.2))
                                    ]),
                                child: Center(
                                  child: Image.asset(
                                    like
                                        ? Images.LIKE_ICON_FILLED
                                        : Images.LIKE_ICON3,
                                    height: 13,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    locationRow(),
                    SizedBox(
                      height: 3,
                    ),
                    ratingAndTime(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dealImage() {
    double distance = widget.modelData.distance ?? 0.0;
    return Expanded(
      flex: 2,
      child: Container(
        height: 130,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    CachedNetworkImageProvider(widget.modelData.featuredImage!),
                fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(14)),
        child: Stack(
          children: [
            Container(
              height: 33,
              width: 50,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    Images.DISCOUNT_FLAG,
                    // height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Center(
                      child: Text(
                        "${widget.modelData.offerDiscount} off",
                        style: FontStyle.PoppinsStyle(10, Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
          distance>=0.0?  Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 22,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: Colors.black
                  ),
                ).blurred(
                    blur: 3,
                    //blurColor: Colors.black26,
                    colorOpacity: 0.1,
                    borderRadius: BorderRadius.circular(20),
                    overlay: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(Images.DIRECTION_ICON),
                        Text(
                          '${ widget.modelData.distance==null?"0.0":widget.modelData.distance!.toStringAsFixed(2)}km',
                          style: FontStyle.PoppinsStyle(9, Colors.white),
                        )
                      ],
                    )),
              ),
            ):Text('')
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
          Expanded(
            child: AutoSizeText(
              '${widget.modelData.location}',
              style: FontStyle.PoppinsStyle(
                11,
                Colors.black26,
              ),
              minFontSize: 8,
            ),
          )
        ],
      ),
    );
  }

  ratingAndTime() {
    DateTime endDate = DateTime.parse(widget.modelData.endDate??DateTime.now().toString());
    int daysLeft = endDate.difference(DateTime.now()).inDays;
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 60,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LIGHT_PINK_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                "$daysLeft days left",
                style: FontStyle.PoppinsStyle(
                    11, Color(ColorCodes.DARK_PINK_COLOR),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          widget.modelData.ratings!="0.0"?   Container(
            // height: 20,
            width: 38,
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
                  "${widget.modelData.ratings}",
                  style: FontStyle.PoppinsStyle(11, Colors.black),
                )
              ],
            ),
          ):Text('')
        ],
      ),
    );
  }
}
