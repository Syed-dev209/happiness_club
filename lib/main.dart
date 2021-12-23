import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/categories/model/offers_category_model.dart';
import 'package:happiness_club/modules/home/Model/featured_offers_model.dart';
import 'package:happiness_club/modules/home/Model/latest_offers_model.dart';
import 'package:happiness_club/modules/home/Model/most_viewed_offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/Model/offers_slider_model.dart';
import 'package:happiness_club/modules/splash/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

const MaterialColor myColor =
    const MaterialColor(ColorCodes.GOLDEN_COLOR, <int, Color>{
  50: Color(ColorCodes.GOLDEN_COLOR),
  100: Color(ColorCodes.GOLDEN_COLOR),
  200: Color(ColorCodes.GOLDEN_COLOR),
  300: Color(ColorCodes.GOLDEN_COLOR),
  400: Color(ColorCodes.GOLDEN_COLOR),
  500: Color(ColorCodes.GOLDEN_COLOR),
  600: Color(ColorCodes.GOLDEN_COLOR),
  700: Color(ColorCodes.GOLDEN_COLOR),
  800: Color(ColorCodes.GOLDEN_COLOR),
  900: Color(ColorCodes.GOLDEN_COLOR)
});

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriesOfferProvider()),
        ChangeNotifierProvider(create: (_) => OffersSliderProvider()),
        ChangeNotifierProvider(create: (_) => MostViewedOffersProvider()),
        ChangeNotifierProvider(create: (_) => LatestOffersProvider()),
        ChangeNotifierProvider(create: (_) => FeaturedOffersProvider()),
        ChangeNotifierProvider(create: (_) => AllOffersProvider()),
        ChangeNotifierProvider(create: (_) => UserModelProvider()),
      ],
      child: MaterialApp(
        title: 'Happiness Club',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: myColor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
