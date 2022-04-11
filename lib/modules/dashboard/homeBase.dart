import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/categories/Screens/categoriesScreen.dart';
import 'package:happiness_club/modules/home/controller/homeController.dart';
import 'package:happiness_club/modules/home/screens/homeScreen.dart';
import 'package:happiness_club/modules/home/widgets/drawer.dart';
import 'package:happiness_club/modules/nearby/nearby_screen.dart';
import 'package:happiness_club/modules/offers/Screens/offerScreen.dart';
import 'package:happiness_club/modules/search/Screens/searchScreen.dart';
import 'package:happiness_club/services/notification_services.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({Key? key}) : super(key: key);

  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  int selectedIndex = 0;
  Widget? body;


  loadData()async{
    //await getFeaturedOffers(context);
    PushNotificationServices().registerUserToken();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    body = HomeScreen();
    loadData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: body,
      bottomNavigationBar: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: BottomNavigationBar(
            elevation: 12.0,
            unselectedFontSize: 12.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            selectedLabelStyle:
                TextStyle(color: Color(ColorCodes.GOLDEN_COLOR)),
            selectedItemColor: Color(ColorCodes.GOLDEN_COLOR),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    selectedIndex == 0
                        ? Images.HOME_ACTIVE
                        : Images.HOME_INACTIVE,
                    height: 20,
                  ),
                  label: LocaleKeys.home.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    selectedIndex == 1
                        ? Images.CATEGORIES_ACTIVE
                        : Images.CATEGORIES_INACTIVE,
                    height: 20.0,
                  ),
                  label: LocaleKeys.categories.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    selectedIndex == 2
                        ? Images.OFFERS_ACTIVE
                        : Images.OFFERS_INACTIVE,
                    height: 20.0,
                  ),
                  label: LocaleKeys.offers.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    selectedIndex == 3
                        ? Images.NEARBY_ACTIVE
                        : Images.NEARBY_INACTIVE,
                    height: 20.0,
                  ),
                  label: LocaleKeys.nearby.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    selectedIndex == 4
                        ? Images.SEARCH_ACTIVE
                        : Images.SEARCH_INACTIVE,
                    height: 18.0,
                  ),
                  label: LocaleKeys.search.tr()),
            ],
            onTap: (index) {
             // print(index);
              setState(() {
                if (index == 0) {
                  body = HomeScreen();
                } else if (index == 1) {
                  body = CategoriesScreen();
                } else if (index == 2) {
                  body = OffersScreen();
                } else if (index == 4) {
                  body = SearchScreen();
                }
                else{
                  body = NearbyScreen();
                }
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
