import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/companies/Controller/companies_controller.dart';
import 'package:happiness_club/modules/companies/Model/comapnies_details_model.dart';
import 'package:happiness_club/modules/companies/Widget/championsCard.dart';
import 'package:happiness_club/modules/companies/Widget/championshipWinner.dart';
import 'package:happiness_club/modules/companies/Widget/luckyDrawWinnerCard.dart';

import '../Widget/comapny_detail_shimmer.dart';

class CompanyDetailsScreen extends StatefulWidget {
  String companyId;
  CompanyDetailsScreen({required this.companyId});

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {

  late StreamController<CompanyDetailsModel?> streamController;

  loadData(){
    getCompanyDetails(context, widget.companyId).then((value){
      if(value!=null){
        streamController.add(value);
        return value;
      }
      else{
        streamController.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    streamController = StreamController<CompanyDetailsModel?>();
    loadData();
  }

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
            child: StreamBuilder<CompanyDetailsModel?>(
              stream: streamController.stream,
              builder: (context,snapshot){
                if(snapshot.hasError || snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CompanyDetailShimmer(),
                  );
                }

                if(snapshot.data == null){
                  return Center(
                    child: Text("No found"),
                  );
                }
                final data = snapshot.data;
                final companyInfo = data!.data!.companyInfo!.first!;
                final champions = data.data!.champions!;
                final champWinners = data.data!.championshipWinners!;
                final luckyWinners = data.data!.luckyWinners!;

                return Column(
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
                    // Container(
                    //   // height: 139,
                    //   // width: 139,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       //shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           image: CachedNetworkImageProvider(companyInfo.logo??Constants.NOT_FOUND_IMAGE_URL),fit: BoxFit.contain)),
                    // ),
                    CachedNetworkImage(
                        imageUrl: companyInfo.logo??Constants.NOT_FOUND_IMAGE_URL,
                      errorWidget: (a,d,f){
                          return Center(
                            child: CachedNetworkImage(imageUrl: Constants.NOT_FOUND_IMAGE_URL,),
                          );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                          "${companyInfo.title!}",
                          style: FontStyles.PoppinsStyle(20, Colors.black,
                              fontWeight: FontWeight.w600),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
                    //       "sed diam nonumy eirmod tempor invidunt ut labore.",
                    //   style: FontStyle.PoppinsStyle(
                    //       14, Color(ColorCodes.GREY_COLOR),
                    //       fontWeight: FontWeight.w500),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    statsContainer(companyInfo),
                    SizedBox(
                      height: 20,
                    ),
                    prizeGrid(companyInfo),
                    SizedBox(
                      height: 20,
                    ),
                    champions.isNotEmpty? Text(
                      "Champions(${champions.length})",
                      style: FontStyles.PoppinsStyle(16, Colors.black,
                          fontWeight: FontWeight.w600),
                    ):Text(""),
                    SizedBox(
                      height: 10,
                    ),
                    champions.isNotEmpty? championsList(champions):Text(""),
                    SizedBox(
                      height: 20,
                    ),
                    champWinners.isNotEmpty? Text(
                      "Championship Winner(${champWinners.length})",
                      style: FontStyles.PoppinsStyle(16, Colors.black,
                          fontWeight: FontWeight.w600),
                    ):Text(""),
                    SizedBox(
                      height: 10,
                    ),
                    champWinners.isNotEmpty? championshipWinnerList(champWinners):Text(""),
                    SizedBox(
                      height: 20,
                    ),
                    luckyWinners.isNotEmpty? Text(
                      "Winners of Lucky Draw(${luckyWinners.length})",
                      style: FontStyles.PoppinsStyle(16, Colors.black,
                          fontWeight: FontWeight.w600),
                    ):Text(""),
                    SizedBox(
                      height: 10,
                    ),
                    luckyWinners.isNotEmpty? luckyDrawWinners(luckyWinners):Text("")
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  championsList(List<CompanyDetailsModelDataChampions?> champs) {
    return SizedBox(
      height: 132,
      width: double.maxFinite,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ChampionCard(model: champs[i]!,);
          },
          separatorBuilder: (context, i) => SizedBox(
                width: 10,
              ),
          itemCount: champs.length),
    );
  }

  championshipWinnerList(List<CompanyDetailsModelDataChampionshipWinners?> champWinners) {
    return SizedBox(
        height: 200,
        width: double.maxFinite,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return ChampionshipWinnerCard(model: champWinners[i]!,);
            },
            separatorBuilder: (context, i) => SizedBox(
                  width: 10,
                ),
            itemCount: champWinners.length));
  }

  luckyDrawWinners(List<CompanyDetailsModelDataLuckyWinners?> lucky) {
    return SizedBox(
        height: 154,
        width: double.maxFinite,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return LuckyDrawWinnerCard(model: lucky[i]!,);
            },
            separatorBuilder: (context, i) => SizedBox(
                  width: 10,
                ),
            itemCount: lucky.length));
  }

  statsContainer(CompanyDetailsModelDataCompanyInfo model) {
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
                  style: FontStyles.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("${model.totalChampionships}",
                        style: FontStyles.PoppinsStyle(
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
                  style: FontStyles.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("${model.totalWinners}",
                        style: FontStyles.PoppinsStyle(
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
                  style: FontStyles.PoppinsStyle(12, Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
                //SizedBox(height: 8,),
                Expanded(
                    child: Text("${model.totalStaff}",
                        style: FontStyles.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  prizeGrid(CompanyDetailsModelDataCompanyInfo model) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: prizeCard("Trophy Number", Images.TROPHY_ICON, "${model.trophyWinners}"),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: prizeCard("Gold Numbers", Images.FIRST_POSITION, "${model.totalGold}"),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: prizeCard("Silver Numbers", Images.SECOND_POSITION, "${model.totalSilver}"),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: prizeCard("Bronze Numbers", Images.THIRD_POSITION, "${model.totalBronze}"),
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
                style: FontStyles.PoppinsStyle(14, Colors.black,
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
            style: FontStyles.PoppinsStyle(22, Color(ColorCodes.GOLDEN_COLOR),
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
