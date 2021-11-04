import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/aboutUs/aboutusScreen.dart';
import 'package:happiness_club/modules/companies/Screens/companiesScreen.dart';
import 'package:happiness_club/modules/newsletter/Screens/newsletterScreen.dart';

class CustomDrawer extends StatelessWidget {
 
  final style = FontStyle.PoppinsStyle(16, Colors.black26);
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
                      style: FontStyle.PoppinsStyle(16, Colors.black),
                    ),
                    subtitle: Text(
                      "johnsmith@gmail.com",
                      style: FontStyle.PoppinsStyle(14, Colors.black26),
                    ),
                  ),
                )),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset(
                      Images.CARD_ICON,
                      height: 20,
                    ),
                    title: Text("Digital card",style: style,),
                  ),
                  ListTile(
                    leading: Image.asset(Images.SCAN_ICON, height: 20),
                    title: Text("Scan QR Code",style: style),
                  ),
                  ListTile(
                    leading:
                        Image.asset(Images.FAVOURITES_ICON, height: 20),
                    title: Text("Favourites",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.PRIZE_ICON,height: 20),
                    title: Text("Prize History",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.CHAMPION_ICON, height: 20),
                    title: Text("Champions",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.COMPANIES, height: 20),
                    onTap: (){
                       Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => CompaniesScreen()));
                    },
                    title: Text("Companies",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.NEWSLETTER, height: 20),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => NewsletterScreen()));
                    },
                    title: Text("Newsletters",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.ARTICLE, height: 20),
                    title: Text("Articles & News",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.ABOUT, height: 20),
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => AboutUsScreen()));
                    },
                    title: Text("About Us",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.CONATCT, height: 20),
                    title: Text("Contact Us",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.SUGGESTIONS, cacheHeight: 20),
                    title: Text("Suggestions",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.TERMS, height: 20),
                    title: Text("Terms & Conditions",style: style),
                  ),
                  ListTile(
                    leading: Image.asset(Images.PRIVACY, height: 20),
                    title: Text("Privacy Policy",style: style),
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
