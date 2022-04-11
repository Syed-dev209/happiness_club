import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/aboutUs/controller/about_controller.dart';
import 'package:happiness_club/modules/aboutUs/widget/partnersCard.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:shimmer/shimmer.dart';

import 'model/about_us_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  StreamController<AboutUsModel?>? aboutController;

  loadData()async{
    getAbout().then((value) {
      if(value!=null){
        aboutController!.add(value);
        return value;
      }
      else{
        aboutController!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aboutController = StreamController<AboutUsModel?>.broadcast();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    aboutController!.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: RefreshIndicator(
            onRefresh: ()async{
              loadData();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(title: LocaleKeys.about_us.tr()),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(Images.LOGO),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Center(
                  //     child: Text(
                  //   "Happiness Club",
                  //   style: FontStyle.PoppinsStyle(24, Colors.black,
                  //       fontWeight: FontWeight.bold),
                  // )),
                  SizedBox(
                    height: 15,
                  ),
                  // Center(
                  //   child: Text(
                  //     "https://happinessclub.ae/",
                  //     style: FontStyle.PoppinsStyle(
                  //         16, Color(ColorCodes.BLUE_COLOR),
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),

                  StreamBuilder<AboutUsModel?>(
                    stream: aboutController!.stream,
                      builder: (context,snapshot){
                      if(snapshot.hasError || !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                        return textShimmer();
                      }
                      if(snapshot.data == null){
                        return Text(
                          "The Happiness Club is a project initiated by the Investment Corporation of Dubai (ICD)"
                              "and was established in January 2017. This initiative was started with three goals in mind, Enjoyment,"
                              "Inspiration, and Work Smart. With over 61,000+ members and 3000+ partners, the Happiness Club aims to"
                              "bring our members and partners together into a beneficial relationship.",
                          style: FontStyles.PoppinsStyle(14, Color(0xff7C86A2),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        );
                      }
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data!.data!.content}",
                            style: FontStyles.PoppinsStyle(14, Color(0xff7C86A2),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15,),
                          statsContainer(snapshot.data!.data!),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            LocaleKeys.videos.tr(),
                            style: FontStyles.PoppinsStyle(16, Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 15,),
                          SizedBox(
                              height: 100,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return VideoCard(videoModel: snapshot.data!.data!.videos![i]!,);
                                  },
                                  separatorBuilder: (context, i) => SizedBox(
                                    width: 12,
                                  ),
                                  itemCount: snapshot.data!.data!.videos!.length))
                        ],
                      );
                      }
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  textShimmer(){
    return Column(
      children: [
        SizedBox(
          height: 25,
          width: double.maxFinite,
          child: Shimmer.fromColors(
              child: Container(
                height: 25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              baseColor: ColorCodes.SHIMMER_BASE_COLOR,
              highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR
          ),
        ),
        SizedBox(height: 15,),
        SizedBox(
          height: 18,
          width: double.maxFinite,
          child: Shimmer.fromColors(
              child: Container(
                height: 18,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)
                ),
              ),
              baseColor: ColorCodes.SHIMMER_BASE_COLOR,
              highlightColor: ColorCodes.SHIMMER_HIGHLIGHT_COLOR
          ),
        )
      ],
    );
  }


  statsContainer(AboutUsModelData data) {
    return Container(
      height: 102,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
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
                      LocaleKeys.total_members.tr(),
                      style: FontStyles.PoppinsStyle(12, Colors.black,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    )),
                //SizedBox(height: 8,),
                Expanded(
                    child: AutoSizeText("${data.totalMembers}",
                        style: FontStyles.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700),minFontSize: 15,))
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
                      LocaleKeys.total_partners.tr(),
                      style: FontStyles.PoppinsStyle(12, Colors.black,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    )),
                //SizedBox(height: 8,),
                Expanded(
                    child: AutoSizeText("${data.totalPartners}",
                        style: FontStyles.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700),minFontSize: 15,))
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
                      LocaleKeys.total_staff_champions.tr(),
                      style: FontStyles.PoppinsStyle(12, Colors.black,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    )),
                //SizedBox(height: 8,),
                Expanded(
                    child: AutoSizeText("${data.totalChampions}",
                        style: FontStyles.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700),minFontSize: 15,))
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
                      LocaleKeys.total_staff_companies.tr(),
                      style: FontStyles.PoppinsStyle(12, Colors.black,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    )),
                //SizedBox(height: 8,),
                Expanded(
                    child: AutoSizeText("${data.totalCompanies}",
                        style: FontStyles.PoppinsStyle(
                            22, Color(ColorCodes.GOLDEN_COLOR),
                            fontWeight: FontWeight.w700),
                      minFontSize: 15,
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
