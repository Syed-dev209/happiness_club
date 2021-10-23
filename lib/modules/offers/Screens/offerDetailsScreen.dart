import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/offers/Widget/offersReviewsScreen.dart';
import 'package:happiness_club/modules/offers/Widget/offersSummaryScreen.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
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
            child: Column(
              children: [
                imageCard(),
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
                    )),
                Expanded(
                  child: TabBarView(
                    //physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: [
                     OffersSummary(),
                      Text(''),
                      OffersReview(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  imageCard() {
    return Container(
      height: 320,
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
              image: AssetImage(Images.DEAL_BG), fit: BoxFit.cover)),
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
    );
  }
}
