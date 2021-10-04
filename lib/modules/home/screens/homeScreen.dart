import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + 300,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(),
              SizedBox(
                height: 25,
              ),
              creditCard(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 245,
                //flex: 2,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 195,
                        smallBox: false,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Deals",
                    style: FontStyle.PoppinsStyle(14, Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "View All",
                    style: FontStyle.PoppinsStyle(
                        12, Color(ColorCodes.GOLDEN_COLOR),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 188,
                        smallBox: true,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Deals",
                    style: FontStyle.PoppinsStyle(14, Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "View All",
                    style: FontStyle.PoppinsStyle(
                        12, Color(ColorCodes.GOLDEN_COLOR),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return DealCard(
                        width: 180,
                        smallBox: true,
                      );
                    },
                    separatorBuilder: (context, i) => SizedBox(
                          width: 10,
                        ),
                    itemCount: 10),
              )
            ],
          ),
        ),
      ),
    );
  }

  appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 20,
          child: SvgPicture.asset(Images.DRAWER_ICON),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 45,
            width: 45,
            child: Image.asset(
              Images.LOGO,
            ),
          ),
        ),
        Expanded(
          child: Text("Sign Up/Login",
              style: FontStyle.PoppinsStyle(11, Color(ColorCodes.GOLDEN_COLOR),
                  fontWeight: FontWeight.bold)),
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
