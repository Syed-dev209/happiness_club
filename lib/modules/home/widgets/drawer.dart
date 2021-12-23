import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/aboutUs/aboutusScreen.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/champions/screens/champions_screen.dart';
import 'package:happiness_club/modules/companies/Screens/companiesScreen.dart';
import 'package:happiness_club/modules/contactUs/contact_us_screen.dart';
import 'package:happiness_club/modules/digitalCard/screens/digital_card_screen.dart';
import 'package:happiness_club/modules/favourites/Screen/favourites_screen.dart';
import 'package:happiness_club/modules/home/controller/qr_controller.dart';
import 'package:happiness_club/modules/newsletter/Screens/newsletterScreen.dart';
import 'package:happiness_club/modules/prizeHistory/screens/prize_history_screen.dart';
import 'package:happiness_club/modules/termsAndPrivacy/terms_and_privacy_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final style =
      FontStyle.PoppinsStyle(14, Colors.black26, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xfffefefe),
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 2),
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
                                      image:
                                          AssetImage(Images.CATEGORIES_BG))))),
                    ),
                    title: Text(
                      "John Smith",
                      style: FontStyle.PoppinsStyle(16, Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "johnsmith@gmail.com",
                      style: FontStyle.PoppinsStyle(12, Colors.black26,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>DigitalCardScreen()));
                    },
                    leading: Image.asset(
                      Images.CARD_ICON,
                      height: 20,
                    ),
                    title: Text(
                      "Digital card",
                      style: style,
                    ),
                  ),
                  ListTile(
                    onTap: ()async{
                      var result = await BarcodeScanner.scan();
                      scanQrResult(context, result.rawContent).then((value) {
                        if(Provider.of<UserModelProvider>(context,listen: false).loggedIn){
                          validateCustomer(context, result.rawContent);
                        }
                      });
                      //print(result.type); // The result type (barcode, cancelled, failed)
                      print(result.rawContent); // The barcode content
                      //print(result.format); // The barcode format (as enum)
                      //print(result.formatNote);
                    },
                    leading: Image.asset(Images.SCAN_ICON, height: 20),
                    title: Text("Scan QR Code", style: style),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => FavouritesScreen()));
                    },
                    leading: Image.asset(Images.FAVOURITES_ICON, height: 20),
                    title: Text("Favourites", style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => PrizeHistoryScreen()));
                    },
                    leading: Image.asset(Images.PRIZE_ICON, height: 20),
                    title: Text("Prize History", style: style),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => ChampionsScreen()));
                    },
                    leading: Image.asset(Images.CHAMPION_ICON, height: 20),
                    title: Text("Champions", style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.COMPANIES, height: 20),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => CompaniesScreen()));
                    },
                    title: Text("Companies", style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.NEWSLETTER, height: 20),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => NewsletterScreen()));
                    },
                    title: Text("Newsletters", style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.ARTICLE, height: 20),
                    title: Text("Articles & News", style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.ABOUT, height: 20),
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => AboutUsScreen()));
                    },
                    title: Text("About Us", style: style),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => ContactUsScreen()));
                    },
                    leading: Image.asset(Images.CONATCT, height: 20),
                    title: Text("Contact Us", style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.SUGGESTIONS, height: 20),
                    title: Text("Suggestions", style: style),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => TermsAndPrivacyScreen(type: Constants.TERMS)));
                    },
                    leading: Image.asset(Images.TERMS, height: 20),
                    title: Text("Terms & Conditions", style: style),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => TermsAndPrivacyScreen(type: Constants.PRIVACY)));
                    },
                    leading: Image.asset(Images.PRIVACY, height: 20),
                    title: Text("Privacy Policy", style: style),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
