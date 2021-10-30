import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/aboutUs/aboutusScreen.dart';
import 'package:happiness_club/modules/newsletter/Screens/newsletterScreen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
                          color: Colors.red,
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
                    title: Text("Digital card"),
                  ),
                  ListTile(
                    title: Text("Scan QR Code"),
                  ),
                  ListTile(
                    title: Text("Favourites"),
                  ),
                  ListTile(
                    title: Text("Prize History"),
                  ),
                  ListTile(
                    title: Text("Champions"),
                  ),
                  ListTile(
                    title: Text("Companies"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => NewsletterScreen()));
                    },
                    title: Text("Newsletters"),
                  ),
                  ListTile(
                    title: Text("Articles & Newa"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => AboutUsScreen()));
                    },
                    title: Text("About Us"),
                  ),
                  ListTile(
                    title: Text("Contact Us"),
                  ),
                  ListTile(
                    title: Text("Suggestions"),
                  ),
                  ListTile(
                    title: Text("Terms & Conditions"),
                  ),
                  ListTile(
                    title: Text("Privacy Policy"),
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
