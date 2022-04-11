import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:blur/blur.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/most_viewed_offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';

class DealCard extends StatefulWidget {
  double width;
  bool smallBox;
  OffersModelData modelData;
  String? type;
  DealCard({required this.width, required this.smallBox, required this.modelData,required this.type});

  @override
  State<DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  int daysLeft=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     DateTime endDate = DateTime.parse(widget.modelData.endDate!);
     int days = endDate.difference(DateTime.now()).inDays;
     days <=0 ? daysLeft =0: daysLeft=days;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>OfferDetailsScreen(offerId: widget.modelData.id.toString())));
      },
      child: Container(
        width: widget.width,
        padding: !widget.smallBox
            ? EdgeInsets.symmetric(horizontal: 10, vertical: 10)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dealImage(),
            Expanded(
              child: Padding(
                padding: widget.smallBox
                    ? EdgeInsets.symmetric(horizontal: 10, vertical: 2)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.modelData.categoryName}",
                        style: FontStyles.PoppinsStyle(
                            11, Color(ColorCodes.BLUE_COLOR),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "${widget.modelData.title}",
                        style: FontStyles.PoppinsStyle(14, Colors.black,
                            fontWeight: FontWeight.w500),
                        minFontSize: 5,
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
    return Expanded(
      flex: 2,
      child: Container(
        height: 130,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            image: widget.modelData.featuredImage!=null?DecorationImage(
                image: CachedNetworkImageProvider(
                    widget.modelData.featuredImage!,
                ),
                fit: BoxFit.cover):DecorationImage(image:AssetImage(Images.NO_IMAGE_PLACEHOLDER)),
            color: Colors.white,
            borderRadius: !widget.smallBox
                ? BorderRadius.circular(14)
                : BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14))),
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
                    padding: EdgeInsets.only(bottom: 8,left: 2,right: 2),
                    child: Center(
                      child: AutoSizeText(
                        "${widget.modelData.offerDiscount} ${LocaleKeys.off.tr()}",
                        style: FontStyles.PoppinsStyle(10, Colors.white,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        minFontSize: 5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
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
                    blurColor: Colors.black,
                    colorOpacity: 0.3,
                    borderRadius: BorderRadius.circular(20),
                    overlay: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: SvgPicture.asset(Images.DIRECTION_ICON)),
                        Text(
                            widget.modelData.distance!=null?'${widget.modelData.distance!.toStringAsFixed(0)} km':"0 Km",
                          style: FontStyles.PoppinsStyle(9, Colors.white),
                        )
                      ],
                    )),
              ),
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
          Expanded(
            child: AutoSizeText('${widget.modelData.location}',
                style: FontStyles.PoppinsStyle(
                  11.5,
                  Colors.black26,
                ),minFontSize: 8,maxLines: 2,),
          )
        ],
      ),
    );
  }

  ratingAndTime() {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 25,
            width: 60,
            decoration: BoxDecoration(
                color: Color(ColorCodes.LIGHT_PINK_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: AutoSizeText(
                daysLeft<=0?"1 ${LocaleKeys.day_left.tr()}" :"$daysLeft ${LocaleKeys.days_left.tr()}",
                style: FontStyles.PoppinsStyle(
                    10, Color(ColorCodes.DARK_PINK_COLOR),
                    fontWeight: FontWeight.w600),
                minFontSize: 6,
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          widget.modelData.ratings!="0.0"?  Container(
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
                  style: FontStyles.PoppinsStyle(10, Colors.black),
                )
              ],
            ),
          ):Text('')
        ],
      ),
    );
  }
}
