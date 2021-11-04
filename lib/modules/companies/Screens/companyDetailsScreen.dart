import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({Key? key}) : super(key: key);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(Images.BACK_BUTTON)),
                ),
                Container(
                  height: 139,
                  width: 139,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(Images.DEAL_BG), fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                  "Red Lobster",
                  style: FontStyle.PoppinsStyle(20, Colors.black,
                      fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                  "sed diam nonumy eirmod tempor invidunt ut labore.",
                  style: FontStyle.PoppinsStyle(
                      14, Color(ColorCodes.GREY_COLOR),
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                statsContainer(),
                SizedBox(height: 20,),
                prizeGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }

  statsContainer() {
    return Container(
      height: 102,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }

  prizeGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: prizeCard(),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: prizeCard(),
            )
          ],
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: prizeCard(),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: prizeCard(),
            )
          ],
        ),
      ],
    );
  }

  prizeCard() {
    return Container(
      height: 105,
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
