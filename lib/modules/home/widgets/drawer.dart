import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/LuckyDraw/Screens/lucky_draw_screen.dart';
import 'package:happiness_club/modules/aboutUs/aboutusScreen.dart';
import 'package:happiness_club/modules/announcements/announcements_screen.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/auth/Screens/customer_info_input_screen.dart';
import 'package:happiness_club/modules/auth/Screens/help_customer_screen.dart';
import 'package:happiness_club/modules/champions/screens/champions_screen.dart';
import 'package:happiness_club/modules/companies/Screens/companiesScreen.dart';
import 'package:happiness_club/modules/contactUs/contact_us_screen.dart';
import 'package:happiness_club/modules/dashboard/homeBase.dart';
import 'package:happiness_club/modules/digitalCard/screens/digital_card_screen.dart';
import 'package:happiness_club/modules/favourites/Screen/favourites_screen.dart';
import 'package:happiness_club/modules/home/controller/qr_controller.dart';
import 'package:happiness_club/modules/home/widgets/custom_switch.dart';
import 'package:happiness_club/modules/newsletter/Screens/newsletterScreen.dart';
import 'package:happiness_club/modules/termsAndPrivacy/terms_and_privacy_screen.dart';
import 'package:happiness_club/services/storage_service.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import '../../prizeHistory/screens/prize_history_screen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final style =
  FontStyles.PoppinsStyle(14.5, Color(0xff7C86A2),
      fontWeight: FontWeight.w500);
  int language = 0;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    bool fullAccess = false;
    final user = Provider.of<UserModelProvider>(context, listen: false);
    var formatter = DateFormat("MM/yy", "en");
    var date;
    if (user.loggedIn && user.expDate!="-") {
      date = formatter.format(
        DateTime.parse("${user.expDate} 00:00:00.000"),
      );
    }
    else{
      date="-";
    }

    if(user.accessType=="full"){
      fullAccess = true;
    }

    var check = StorageServices().readDataFromStorage(StorageKeys.LANGUAGE);
    if(check=="")
    {
      language=0;
    }
    else{
      language = check;
    }

    return Drawer(
      child: Container(
        color: Color(0xfffefefe),
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Center(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 50),
                    leading: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.black.withOpacity(0.07))),
                      child: Center(
                          child: Container(
                              height: 66,
                              width: 66,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: CachedNetworkImageProvider(
                                          Constants.ALT_IMAGE))))),
                    ),
                    title: Text(
                      Provider.of<UserModelProvider>(context, listen: false)
                          .name,
                      style: FontStyles.PoppinsStyle(16, Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: user.loggedIn
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.memberShip}",
                                style: FontStyles.PoppinsStyle(
                                    12, Color(ColorCodes.GOLDEN_COLOR),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${LocaleKeys.expiry.tr()} : $date",
                                style: FontStyles.PoppinsStyle(
                                    11, Color(ColorCodes.GREY_COLOR),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${LocaleKeys.company.tr()} : ${user.company}",
                                style: FontStyles.PoppinsStyle(
                                    11, Color(ColorCodes.GREY_COLOR),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),
                )),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) => HomeBase()));
                    },
                    leading: Icon(
                      Icons.home,
                      color: Color(ColorCodes.GOLDEN_COLOR),
                      size: 28,
                    ),
                    title: Text(
                      LocaleKeys.dashboard.tr(),
                      style: style,
                    ),
                  ),
                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && user.accessType!="guest"
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => DigitalCardScreen()));
                          },
                          leading: Image.asset(
                            Images.CARD_ICON,
                            height: 20,
                          ),
                          title: Text(
                            LocaleKeys.digital_card.tr(),
                            style: style,
                          ),
                        )
                      : SizedBox.shrink(),


                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && fullAccess
                      ? ListTile(
                          onTap: () async {
                            var result = await BarcodeScanner.scan();
                            scanQrResult(context, result.rawContent)
                                .then((value) {
                              //print("==>$value");
                              if (value == "success") {
                                if (Provider.of<UserModelProvider>(context,
                                        listen: false)
                                    .loggedIn) {
                                  validateCustomer(context, result.rawContent);
                                } else {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              InputCustomerInfo(
                                                qrResult: result.rawContent,
                                              )));
                                }
                              } else {
                                //Navigator.pop(context);
                              }
                            });
                           // print(result.rawContent); // The barcode content
                          },
                          leading: Image.asset(Images.SCAN_ICON, height: 20),
                          title: Text(LocaleKeys.scan_qr_code.tr(), style: style),
                        )
                      : SizedBox.shrink(),
                  Provider.of<UserModelProvider>(context, listen: false)
                      .loggedIn && fullAccess
                      ? ListTile(
                    onTap: ()  {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => LuckyDrawScreen()));
                      // print(result.rawContent); // The barcode content
                    },
                    leading: Image.asset(Images.SCAN_ICON, height: 20),
                    title: Text(LocaleKeys.lucky_draw_event.tr(), style: style),
                  )
                      : SizedBox.shrink(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => FavouritesScreen()));
                    },
                    leading: Image.asset(Images.FAVOURITES_ICON, height: 20),
                    title: Text(LocaleKeys.favourites.tr(), style: style),
                  ),
                  Provider.of<UserModelProvider>(context, listen: false)
                      .loggedIn && fullAccess ?ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PrizeHistoryScreen()));
                    },
                    leading: Image.asset(Images.PRIZE_ICON, height: 20),
                    title: Text(LocaleKeys.prize_history.tr(), style: style),
                  ):SizedBox.shrink(),
                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && fullAccess
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ChampionsScreen()));
                          },
                          leading:
                              Image.asset(Images.CHAMPION_ICON, height: 20),
                          title: Text(LocaleKeys.champions.tr(), style: style),
                        )
                      : SizedBox.shrink(),
                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && fullAccess
                      ? ListTile(
                          leading: Image.asset(Images.COMPANIES, height: 20),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => CompaniesScreen()));
                          },
                          title: Text(LocaleKeys.companies.tr(), style: style),
                        )
                      : SizedBox.shrink(),

                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && fullAccess
                      ? ListTile(
                          leading: Image.asset(Images.NEWSLETTER, height: 20),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => NewsletterScreen()));
                          },
                          title: Text(LocaleKeys.newsletter.tr(), style: style),
                        )
                      : SizedBox.shrink(),
                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn && fullAccess
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => AnnouncementsScreen()));
                          },
                          leading: Image.asset(Images.ARTICLE, height: 20),
                          title: Text(LocaleKeys.announcement.tr(), style: style),
                        )
                      : SizedBox.shrink(),

                  ListTile(
                    leading: Image.asset(Images.ABOUT, height: 20),
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => AboutUsScreen()));
                    },
                    title: Text(LocaleKeys.about_us.tr(), style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => ContactUsScreen()));
                    },
                    leading: Image.asset(Images.CONATCT, height: 20),
                    title: Text(LocaleKeys.contact_us.tr(), style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => HelpCustomerScreen()));
                    },
                    leading: Image.asset(Images.SUGGESTIONS, height: 20),
                    title: Text(LocaleKeys.suggestion.tr(), style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => TermsAndPrivacyScreen(
                                  type: LocaleKeys.terms_and_condition.tr())));
                    },
                    leading: Image.asset(Images.TERMS, height: 20),
                    title: Text(LocaleKeys.terms_and_condition.tr(), style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => TermsAndPrivacyScreen(
                                  type: LocaleKeys.privacy_policy.tr())));
                    },
                    leading: Image.asset(Images.PRIVACY, height: 20),
                    title: Text(LocaleKeys.privacy_policy.tr(), style: style),
                  ),
                  Provider.of<UserModelProvider>(context, listen: false)
                          .loggedIn
                      ? ListTile(
                          onTap: () {
                            Provider.of<UserModelProvider>(context,
                                    listen: false)
                                .logOutUser();
                            Navigator.pop(context);
                            showToast(context, LocaleKeys.user_log_out.tr());

                          },
                          leading: Icon(
                            Icons.logout,
                            color: Color(ColorCodes.GOLDEN_COLOR),
                          ),
                          title: Text(LocaleKeys.logout.tr(), style: style),
                        )
                      : SizedBox.shrink(),

                  ListTile(

                     leading: Icon(Icons.language,color: Color(ColorCodes.GOLDEN_COLOR),),
                      title:Text(LocaleKeys.language.tr(),style: style,),
                    trailing: SizedBox(
                      width: 120,
                      child: AnimatedToggle(
                        initialPosition: language==0?true:false,
                        values: [LocaleKeys.english.tr(), LocaleKeys.arabic.tr()],
                        onToggleCallback: (value) {
                          print(value);
                          StorageServices().writeDataToStorage(StorageKeys.LANGUAGE, value);
                          if(value==0){
                            context.setLocale(Locale('en'));
                            Provider.of<UserModelProvider>(context,listen: false).setLanguage(0);
                          }
                          else{
                            context.setLocale(Locale('ar'));
                            Provider.of<UserModelProvider>(context,listen: false).setLanguage(1);
                          }
                          setState(() {
                            language = value;
                          });
                        },
                        buttonColor: Color(ColorCodes.GOLDEN_COLOR),
                        backgroundColor: const Color(0xFFB5C1CC),
                        textColor:  Colors.white,
                      ),
                    ),


                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Platform.isAndroid? "Version 16.1.0(4)":"Version 3.3.0(1)",style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  fontSize: 15,
                  color: Color(0xff7C86A2)

                ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
