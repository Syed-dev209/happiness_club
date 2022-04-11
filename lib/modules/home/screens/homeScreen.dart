import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/login_screen.dart';
import 'package:happiness_club/modules/auth/Screens/phone_input_screen.dart';
import 'package:happiness_club/modules/auth/Screens/signup_screen.dart';
import 'package:happiness_club/modules/categories/Screens/categoriesScreen.dart';
import 'package:happiness_club/modules/categories/Widget/categoriesCard.dart';
import 'package:happiness_club/modules/categories/Widget/category_card_shimmer.dart';
import 'package:happiness_club/modules/categories/controller/categoriesController.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/featured_offers_model.dart';
import 'package:happiness_club/modules/home/Model/latest_offers_model.dart';
import 'package:happiness_club/modules/home/Model/most_viewed_offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/modules/home/controller/homeController.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:happiness_club/modules/home/widgets/deal_shimmer_card.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/modules/offers/Screens/offerScreen.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../digitalCard/screens/digital_card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
    Images.DISCOUNT_OFFER,
  ];
  int currentPos = 0;

  onRefreshCall() async {
    Provider.of<CategoriesOfferProvider>(context, listen: false)
        .clearProvider();
    Provider.of<OffersSliderProvider>(context, listen: false).clearProvider();
    Provider.of<MostViewedOffersProvider>(context, listen: false)
        .clearProvider();
    Provider.of<LatestOffersProvider>(context, listen: false).clearProvider();
    Provider.of<FeaturedOffersProvider>(context, listen: false).clearProvider();

    // await getOfferCategories(context);
    // await getSliderImages(context);
    // await getMostViewedOffers(context);
    // await getLatestOffers(context);
    // await getFeaturedOffers(context);
    await getDashboardData(context);
    showToast(context, "Page refreshed");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height + 300,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return onRefreshCall();
                },
                child: ListView(
                  children: [
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // creditCard(), ///credit card
                    SizedBox(
                      height: 20,
                    ),
                    discountSlider(),

                    ///slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.categories.tr(),
                          style: FontStyles.PoppinsStyle(14, Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => Scaffold(
                                          body: CategoriesScreen(),
                                        )));
                          },
                          child: Text(
                            LocaleKeys.view_all.tr(),
                            style: FontStyles.PoppinsStyle(
                                12, Color(ColorCodes.GOLDEN_COLOR),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<CategoriesOfferProvider>(
                        builder: (context, data, _) {
                      if (data.modelData == null) {
                        return SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return CategoryCardShimmer();
                              },
                              separatorBuilder: (context, i) => SizedBox(
                                    width: 10,
                                  ),
                              itemCount: 3),
                        );
                      }
                      return SizedBox(
                        ///categories
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return CategoriesCard(
                                modelData: data.modelData!.data![i]!,
                              );
                            },
                            separatorBuilder: (context, i) => SizedBox(
                                  width: 10,
                                ),
                            itemCount: data.modelData!.data!.length),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<MostViewedOffersProvider>(
                      builder: (context, data, _) {
                        if (data.state == StorageKeys.STATE_LOADING &&
                            data.modelData == null) {
                          return SizedBox(
                            height: 260,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return DealShimmerCard(
                                    smallCard: false,
                                  );
                                },
                                separatorBuilder: (context, i) => SizedBox(
                                      width: 10,
                                    ),
                                itemCount: 4),
                          );
                        }
                        if (data.state == StorageKeys.STATE_FINISHED &&
                            data.modelData == null) {
                          return Center(
                            child: Text(LocaleKeys.no_offers.tr()),
                          );
                        }
                        return data.modelData!.data!.isNotEmpty
                            ? SizedBox(
                                height: 260,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return DealCard(
                                        width: 230,
                                        smallBox: false,
                                        modelData: data.modelData!.data![i]!,
                                        type: StorageKeys.MOST_VIEWED_OFFERS,
                                      );
                                    },
                                    separatorBuilder: (context, i) => SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: data.modelData!.data!.length),
                              )
                            : Center(
                                child: Text(LocaleKeys.no_offers.tr()),
                              );
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.new_deals.tr(),
                          style: FontStyles.PoppinsStyle(14, Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => Scaffold(
                                            body: OffersScreen(
                                          heading: "New Deals",
                                        ))));
                          },
                          child: Text(
                            LocaleKeys.view_all.tr(),
                            style: FontStyles.PoppinsStyle(
                                12, Color(ColorCodes.GOLDEN_COLOR),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Consumer<LatestOffersProvider>(
                      builder: (context, data, _) {
                        if (data.state == StorageKeys.STATE_LOADING &&
                            data.modelData == null) {
                          return SizedBox(
                            height: 220,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return DealShimmerCard(
                                    smallCard: true,
                                  );
                                },
                                separatorBuilder: (context, i) => SizedBox(
                                      width: 10,
                                    ),
                                itemCount: 4),
                          );
                        }
                        if (data.state == StorageKeys.STATE_FINISHED &&
                            data.modelData == null) {
                          return Center(
                            child: Text(LocaleKeys.no_offers.tr()),
                          );
                        }
                        return data.modelData!.data!.isNotEmpty
                            ? SizedBox(
                                height: 220,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return DealCard(
                                        width: 161,
                                        smallBox: true,
                                        modelData: data.modelData!.data![i]!,
                                        type: StorageKeys.LATEST_OFFERS,
                                      );
                                    },
                                    separatorBuilder: (context, i) => SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: data.modelData!.data!.length),
                              )
                            : Center(
                                child: Text(LocaleKeys.no_offers.tr()),
                              );
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.featured_deals.tr(),
                          style: FontStyles.PoppinsStyle(14, Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => Scaffold(
                                          body: OffersScreen(
                                            heading: "Featured Deals",
                                          ),
                                        )));
                          },
                          child: Text(
                            LocaleKeys.view_all.tr(),
                            style: FontStyles.PoppinsStyle(
                                12, Color(ColorCodes.GOLDEN_COLOR),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Consumer<FeaturedOffersProvider>(
                      builder: (context, data, _) {
                        if (data.state == StorageKeys.STATE_LOADING &&
                            data.modelData == null) {
                          return SizedBox(
                            height: 220,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return DealShimmerCard(
                                    smallCard: true,
                                  );
                                },
                                separatorBuilder: (context, i) => SizedBox(
                                      width: 10,
                                    ),
                                itemCount: 4),
                          );
                        }
                        if (data.state == StorageKeys.STATE_FINISHED &&
                            data.modelData == null) {
                          return Center(
                            child: Text(LocaleKeys.no_offers.tr()),
                          );
                        }
                        return data.modelData!.data!.isNotEmpty
                            ? SizedBox(
                                height: 220,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return DealCard(
                                        width: 161,
                                        smallBox: true,
                                        modelData: data.modelData!.data![i]!,
                                        type: StorageKeys.FEATURED_OFFERS,
                                      );
                                    },
                                    separatorBuilder: (context, i) => SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: data.modelData!.data!.length),
                              )
                            : Center(child: Text(LocaleKeys.no_offers.tr()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  discountSlider() {
    return Consumer<OffersSliderProvider>(
      builder: (context, data, _) {
        if (data.modelData == null) {
          return sliderImageShimmer();
        }
        return Container(
          height: 230,
          child: Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: data.modelData!.data!.length,
                  options: CarouselOptions(
                      aspectRatio: 2.5,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      onPageChanged: (index, val) {
                        setState(() {
                          currentPos = index;
                        });
                      }),
                  itemBuilder: (context, index, h) {
                    return sliderImageContainer(data.modelData!.data![index]!);
                  },
                ),
              ),
              data.modelData!.data!.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        data.modelData!.data!.length,
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPos == index
                                  ? Color(ColorCodes.GOLDEN_COLOR)
                                  : Color(ColorCodes.LITE_GOLDEN_COLOR),
                            ),
                          );
                        },
                      ),
                    )
                  : Text(LocaleKeys.no_offer_discount_found.tr())
            ],
          ),
        );
      },
    );
  }

  Widget sliderImageContainer(OffersSliderModelData data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) =>
                    OfferDetailsScreen(offerId: data.offerId.toString())));
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 230,
            width: double.maxFinite,
            imageUrl: data.imageFilename ?? Constants.NOT_FOUND_IMAGE_URL,
            fit: BoxFit.cover,
            errorWidget: (context, s, dd) {
              return Image.asset(Images.NO_IMAGE);
            },
          ),
        ),
      ),
    );
  }

  sliderImageShimmer() {
    return SizedBox(
      height: 150,
      width: 500,
      child: Shimmer.fromColors(
        baseColor: ColorCodes.SHIMMER_BASE_COLOR,
        highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR,
        child: Container(
          height: 120,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
              height: 30,
              width: 20,
              //color: Colors.red,
              child: Center(
                  child: SvgPicture.asset(
                Images.DRAWER_ICON,
                height: 30,
                width: 20,
              )))),
      leadingWidth: 26,
      title: Container(
        height: 59,
        width: 59,
        child: Image.asset(
          Images.LOGO,
        ),
      ),
      centerTitle: true,
      actions: [
        !Provider.of<UserModelProvider>(context, listen: false).loggedIn
            ? Provider.of<UserModelProvider>(context, listen: false)
                        .accessType !=
                    "guest"
                ? IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                    tooltip: LocaleKeys.login.tr(),
                    icon: Column(
                      children: [
                        ImageIcon(
                          AssetImage(Images.LOGIN_ICON),
                          color: Color(ColorCodes.GOLDEN_COLOR),
                          size: 22,
                        ),
                        Text(
                          LocaleKeys.login.tr(),
                          style: TextStyle(
                              color: Color(ColorCodes.GOLDEN_COLOR),
                              fontSize: 10),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PhoneInputScreen()));
                    },
                  )
                : Text("")

            // ListTile(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //             builder: (context) => DigitalCardScreen()));
            //   },
            //   leading: Image.asset(
            //     Images.CARD_ICON,
            //     height: 20,
            //   ),
            //   title: Text(
            //     "Digital card",
            //     style: style,
            //   ),
            // )
            // GestureDetector(
            //           onTap: (){
            //
            //           },
            //           child:  Text("Sign Up/Login",
            //               style: FontStyles.PoppinsStyle(11, Color(ColorCodes.GOLDEN_COLOR),
            //                   fontWeight: FontWeight.bold)),
            //         )

            : IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                tooltip: LocaleKeys.digital_card.tr(),
                icon: Column(
                  children: [
                    ImageIcon(
                      AssetImage(
                        Images.CARD_ICON,
                      ),
                      color: Color(ColorCodes.GOLDEN_COLOR),
                      size: 22,
                    ),
                    Text(
                      LocaleKeys.card.tr(),
                      style: TextStyle(
                          color: Color(ColorCodes.GOLDEN_COLOR), fontSize: 10),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => DigitalCardScreen()));
                },
              )
      ],
    );
  }

  creditCard() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Images.CREDIT_CARD,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
