import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:blur/blur.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/LuckyDraw/Model/lucky_draw_model.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/favourites/controller/favorites_controller.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:happiness_club/widgets/successpop.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Controller/luck_draw_controller.dart';

class LuckyDrawEventCard extends StatefulWidget {
  LuckDrawModelData modelData;

  LuckyDrawEventCard({required this.modelData});

  @override
  _LuckyDrawEventCardState createState() => _LuckyDrawEventCardState();
}

class _LuckyDrawEventCardState extends State<LuckyDrawEventCard> {
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
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
                  SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            constraints:
                                BoxConstraints(minHeight: 0, maxHeight: 20),
                            child: AutoSizeText(
                              "${widget.modelData.eventTitle}",
                              style: FontStyles.PoppinsStyle(14, Colors.black,
                                  fontWeight: FontWeight.w500),
                              minFontSize: 6,
                              // softWrap: true,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            "${DateFormat("dd MMM yy").format(DateTime.parse(widget.modelData.eventDatetime!))}",
                            style: FontStyles.PoppinsStyle(14, Colors.black,
                                fontWeight: FontWeight.w500),
                            minFontSize: 6,
                            // softWrap: true,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  locationRow(),
                  SizedBox(
                    height: 10,
                  ),
                 widget.modelData.hasLuckyDraw!?  AnimatedCrossFade(
                    firstChild: SizedBox(
                      height: 36,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            setState(() {
                              load = true;
                            });
                            subscribeToEvent(
                                    context, widget.modelData.id.toString())
                                .then((value) {
                              setState(() {
                                load = false;
                              });
                              if (value) {
                                getSuccessPopup();
                              } else {
                                getErrorPopup(
                                    text: "You have already subscribed");
                              }
                            });
                          },
                          child: Text(
                            LocaleKeys.subscribe_to_lucky_draw.tr(),
                            style: FontStyles.PoppinsStyle(12, Colors.white),
                          )),
                    ),
                    secondChild: Center(
                      child: Transform.scale(
                        scale: 0.6,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    crossFadeState: !load
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 500),
                  ):SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
            image: DecorationImage(
                image: CachedNetworkImageProvider(widget.modelData.eventImage ??
                    Constants.NOT_FOUND_IMAGE_URL),
                fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(14)),
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
              '${widget.modelData.eventLocation}',
              style: FontStyles.PoppinsStyle(
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
}
