import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:blur/blur.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/help_customer_screen.dart';
import 'package:happiness_club/modules/favourites/controller/favorites_controller.dart';
import 'package:happiness_club/modules/offers/Models/offer_details_model.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';

class OffersSummary extends StatefulWidget {
  OfferDetailsModelData modelData;
   OffersSummary({required this.modelData});

  @override
  _OffersSummaryState createState() => _OffersSummaryState();
}

class _OffersSummaryState extends State<OffersSummary> {

  String? htmlData;
  dom.Document? document;
  bool like = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    htmlData = """${widget.modelData.description}""";
    document = htmlparser.parse(htmlData);
  }
  @override
  Widget build(BuildContext context) {
    double distance = widget.modelData.distance??0.0;
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
                  Expanded(
                    flex:5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.modelData.categoryName}",
                            style: FontStyle.PoppinsStyle(
                                14, Color(ColorCodes.BLUE_COLOR),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight: 0.0,
                              maxHeight: 30
                            ),
                            child: AutoSizeText(
                              "${widget.modelData.title}",
                              style: FontStyle.PoppinsStyle(
                                  16, Colors.black,
                                  fontWeight: FontWeight.w500),
                              maxLines: 2,
                              minFontSize: 12,
                              maxFontSize: 16,
                            ),
                          ),
                          // SizedBox(
                          //   height: 3,
                          // ),
                          locationRow(),
                          // SizedBox(
                          //   height: 3,
                          // ),
                          ratingAndTime(),
                        ]),
                  ),
                  distance>=0.0? Expanded(
                    child: Container(
                      height: 28,
                      width: 75,
                       padding: EdgeInsets.symmetric(horizontal: 5),
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
                              Expanded(
                                child: SvgPicture.asset(
                                  Images.DIRECTION_ICON,
                                  color: Color(ColorCodes.GOLDEN_COLOR),
                                ),
                              ),
                              SizedBox(height: 1,),
                              Expanded(
                                flex: 3,
                                child: AutoSizeText(
                                  '${widget.modelData.distance==null?"0":widget.modelData.distance!.toStringAsFixed(0)}km',
                                  style: FontStyle.PoppinsStyle(
                                      11, Color(ColorCodes.GOLDEN_COLOR)),
                                  minFontSize: 8,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        )),
                  ):Text("")
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
           Html(data: htmlData,),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    final user = Provider.of<UserModelProvider>(
                        context,
                        listen: false);
                    if (user.loggedIn) {
                      setState(() {
                        like = !like;
                      });
                      markAsFavorite(
                          context, widget.modelData.id.toString()).then((value) {
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
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(
                              ColorCodes.GOLDEN_COLOR,
                            ),
                            width: 2)),
                    child: Center(
                      child: Image.asset(
                        like?Images.LIKE_ICON_FILLED :Images.LIKE_ICON3,
                        height: 25,
                        filterQuality: FilterQuality.high,
                        // width: 10,
                      ),
                    ),
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
                    onPressed: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => HelpCustomerScreen()));

                    },
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
          Expanded(
            child: AutoSizeText('${widget.modelData.location}',
                style: FontStyle.PoppinsStyle(
                  14,
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
    print(widget.modelData.endDate);
    DateTime endDate = DateTime.parse(widget.modelData.endDate??DateTime.now().toString());
    int daysLeft = endDate.difference(DateTime.now()).inDays;
    print(daysLeft);
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 25,
            width: 68,
            constraints: BoxConstraints(
              minHeight: 15,
              maxHeight: 25,
            ),
            decoration: BoxDecoration(
                color: Color(ColorCodes.LIGHT_PINK_COLOR),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: AutoSizeText(
                daysLeft<=0?"1 day left" :"$daysLeft days left",
                style: FontStyle.PoppinsStyle(
                    11, Color(ColorCodes.DARK_PINK_COLOR),
                    fontWeight: FontWeight.w600),
                minFontSize: 5,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
             height: 25,
            width: 42,
            constraints: BoxConstraints(
              minHeight: 15,
              maxHeight: 25
            ),
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
                AutoSizeText(
                  "${widget.modelData.ratings}",
                  style: FontStyle.PoppinsStyle(11, Colors.black),
                  minFontSize: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
