import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/companies/Widget/championsCard.dart';
import 'package:happiness_club/modules/companies/Widget/championshipWinner.dart';
import 'package:happiness_club/modules/companies/Widget/luckyDrawWinnerCard.dart';

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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(Images.BACK_BUTTON)),
                  ),
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
                SizedBox(
                  height: 20,
                ),
                prizeGrid(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Champions(20)",
                  style: FontStyle.PoppinsStyle(16, Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                championsList(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Championship Winner(10)",
                  style: FontStyle.PoppinsStyle(16, Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                championshipWinnerList(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Winners of Lucky Draw(10)",
                  style: FontStyle.PoppinsStyle(16, Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                luckyDrawWinners()
              ],
            ),
          ),
        ),
      ),
    );
  }

  championsList() {
    return SizedBox(
      height: 132,
      width: double.maxFinite,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ChampionCard();
          },
          separatorBuilder: (context, i) => SizedBox(
                width: 10,
              ),
          itemCount: 10),
    );
  }

  championshipWinnerList() {
    return SizedBox(
        height: 200,
        width: double.maxFinite,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return ChampionshipWinnerCard();
            },
            separatorBuilder: (context, i) => SizedBox(
                  width: 10,
                ),
            itemCount: 10));
  }

  luckyDrawWinners() {
    return SizedBox(
        height: 154,
        width: double.maxFinite,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return LuckyDrawWinnerCard();
            },
            separatorBuilder: (context, i) => SizedBox(
                  width: 10,
                ),
            itemCount: 10));
  }

  statsContainer() {
    return Container(
      height: 102,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "Total\nChampions",
                  style: FontStyle.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("22",
                        style: FontStyle.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700)))
              ],
            ),
          ),
          Image.asset(Images.DOTTED_LINE),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "Total\nWinners",
                  style: FontStyle.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("32",
                        style: FontStyle.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700)))
              ],
            ),
          ),
          Image.asset(Images.DOTTED_LINE),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "Total Staff\nMemebers",
                  style: FontStyle.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("50",
                        style: FontStyle.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  prizeGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: prizeCard("Trophy Number", Images.TROPHY_ICON, "68"),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: prizeCard("Gold Numbers", Images.FIRST_POSITION, "52"),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: prizeCard("Silver Numbers", Images.SECOND_POSITION, "52"),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: prizeCard("Gold Numbers", Images.THIRD_POSITION, "52"),
            )
          ],
        ),
      ],
    );
  }

  prizeCard(String title, String imagePath, String num) {
    return Container(
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: FontStyle.PoppinsStyle(14, Colors.black,
                    fontWeight: FontWeight.w400),
              )),
              Expanded(child: SvgPicture.asset(imagePath))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            num,
            style: FontStyle.PoppinsStyle(22, Color(ColorCodes.GOLDEN_COLOR),
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
