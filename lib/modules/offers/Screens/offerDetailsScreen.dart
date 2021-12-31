import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/offers/Controller/offers_controller.dart';
import 'package:happiness_club/modules/offers/Models/offer_details_model.dart';
import 'package:happiness_club/modules/offers/Models/offer_revies_model.dart';
import 'package:happiness_club/modules/offers/Widget/offersLocationScreen.dart';
import 'package:happiness_club/modules/offers/Widget/offersReviewsScreen.dart';
import 'package:happiness_club/modules/offers/Widget/offersSummaryScreen.dart';
import 'package:happiness_club/widgets/snackBars.dart';

class OfferDetailsScreen extends StatefulWidget {
  String offerId;

  OfferDetailsScreen({required this.offerId});

  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> tabs = [
    Tab(
      text: " Summary",
    ),
    Tab(
      text: " Location",
    ),
    Tab(
      text: " Reviews",
    ),
  ];
  TabController? controller;
  StreamController<OfferDetailsModel?>? offersDetailStream;


  loadOfferDetails()async{
    getOffersDetail(offerId: widget.offerId).then((value) {
      print(value);
      if(value!=null){
       offersDetailStream!.add(value);
       return value;
      }
      else{
        offersDetailStream!.add(null);
        return null;
      }
    });
    addViewToOffer(widget.offerId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
    offersDetailStream= StreamController<OfferDetailsModel?>();
    loadOfferDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
    offersDetailStream!.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: StreamBuilder<OfferDetailsModel?>(
              stream: offersDetailStream!.stream,
              builder: (context,snapshot){
                if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: getLoader(),
                  );
                }
                if(snapshot.data==null){
                  return Center(
                    child: noDataFound(),
                  );
                }
                return Column(
                  children: [
                    imageCard(snapshot.data!.data!.featuredImage ?? Constants.NOT_FOUND_IMAGE_URL,snapshot.data!.data!.offerDiscount ?? "0"),
                    SizedBox(height: 15,),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        height: 45.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black26,width: 1.5),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TabBar(
                          tabs: tabs,
                          controller: controller,
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          labelColor: Color(ColorCodes.GOLDEN_COLOR),
                          //  indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.zero,
                          indicator: BubbleTabIndicator(
                            indicatorRadius: 20.0,
                            indicatorHeight: 35.0,
                            indicatorColor: ColorCodes.WHITE_COLOR,
                            // tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          ),
                        )
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: [
                          OffersSummary(modelData: snapshot.data!.data!,),
                          OfferLocation(offerId: widget.offerId),
                          OffersReview(offerId: widget.offerId,),
                        ],
                      ),
                    )
                  ],
                );
              },
            )
        ),
      ),
    );
  }
  noDataFound(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Images.NO_DATA),
        SizedBox(height: 15,),
        Text(
          "No offer details found",
          style: FontStyle.PoppinsStyle(
              15,
              Color(ColorCodes.GOLDEN_COLOR).withOpacity(0.4),
              fontWeight: FontWeight.w600),)
      ],
    );
  }
  imageCard(String imageUrl, String offer) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(5, 7),
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 100)
              ],
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: ColorCodes.WHITE_COLOR,
                    child: SvgPicture.asset(Images.BACK_BUTTON),
                  )),
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 40,
            width: 60,
            margin: EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                SvgPicture.asset(
                  Images.DISCOUNT_FLAG,
                  fit: BoxFit.fill,
                  // height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: Text(
                      "$offer off",
                      style: FontStyle.PoppinsStyle(10, Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
