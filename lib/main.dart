import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/modules/splash/splashScreen.dart';

void main() {
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
    return MaterialApp(
      title: 'Happiness Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myColor,
      ),
      home: SplashScreen(),
    );
  }
}
