import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Controller/offers_controller.dart';
import 'package:happiness_club/modules/offers/Widget/offer_card_shimmer.dart';
import 'package:happiness_club/modules/offers/Widget/offersCard.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  String heading = LocaleKeys.offers.tr();
  OffersScreen({this.heading = "Offers"});

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  ScrollController? scrollController;
  int start = 0, end = 9;
  bool loading = false;
  _scrollListener() {
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      setState(() {
        loading = true;
      });
      loadData();
      // setState(() {
      //   message = "reach the bottom";
      // });
    }
    if (scrollController!.offset <=
            scrollController!.position.minScrollExtent &&
        !scrollController!.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      // });
    }
  }

  Future loadData({bool reset = false}) async {
    if (reset) {
      start = 0;
      end = 9;
    }
    log(start.toString());
    log(end.toString());
    getAllOffers(context, start, end).then((value) {
      start = start + 10;
      end = end + 10;

      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(_scrollListener);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          appBar(widget.heading),
          Expanded(child: Consumer<AllOffersProvider>(
            builder: (context, data, _) {
              if (data.modelData == null) {
                return ListView.separated(
                    itemBuilder: (context, i) {
                      return OfferCardShimmer();
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          height: 10,
                        ),
                    itemCount: 3);
              }
              return RefreshIndicator(
                onRefresh: () async {
                  loadData(reset: true);
                },
                child: ListView.separated(
                    controller: scrollController!,
                    itemBuilder: (context, i) {
                      return OffersCard(modelData: data.modelData!.data![i]!);
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          height: 10,
                        ),
                    itemCount: data.modelData!.data!.length),
              );
            },
          )),
          loading ? getLoader() : Text("")
        ],
      ),
    );
  }

  appBar(String heading) {
    return GestureDetector(
      onTap: () {
        Navigator.maybePop(context);
      },
      child: Container(
        height: 50,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(Images.BACK_BUTTON),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.3,
            // ),
            Text(
              heading,
              style: FontStyles.PoppinsStyle(17, Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            PopupMenuButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 05, vertical: 10),
                  child: SvgPicture.asset(Images.APPBAR_DROP_ICON),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          LocaleKeys.most_viewed.tr(),
                          style: FontStyles.PoppinsStyle(
                              17, Colors.black.withOpacity(0.6)),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text(LocaleKeys.best_rated.tr(),
                            style: FontStyles.PoppinsStyle(
                                17, Colors.black.withOpacity(0.6))),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text(LocaleKeys.featured.tr(),
                            style: FontStyles.PoppinsStyle(
                                17, Colors.black.withOpacity(0.6))),
                        value: 3,
                      ),
                    ])
            // GestureDetector(
            //     onTap: () {

            //     }, child: SvgPicture.asset(Images.APPBAR_DROP_ICON))
          ],
        ),
      ),
    );
  }
}
