import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/aboutUs/controller/about_controller.dart';
import 'package:happiness_club/modules/aboutUs/widget/partnersCard.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:shimmer/shimmer.dart';

import 'model/about_us_model.dart';

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
                  CustomAppBar(title: "About Us"),
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
                  Center(
                      child: Text(
                    "Happiness Club",
                    style: FontStyle.PoppinsStyle(24, Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "https://happinessclub.ae/",
                      style: FontStyle.PoppinsStyle(
                          20, Color(ColorCodes.BLUE_COLOR),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
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
                          style: FontStyle.PoppinsStyle(17, Color(ColorCodes.GREY_COLOR),
                              fontWeight: FontWeight.w500),
                        );
                      }
                      return  Text(
                        "${snapshot.data!.data!.content}",
                        style: FontStyle.PoppinsStyle(17, Color(ColorCodes.GREY_COLOR),
                            fontWeight: FontWeight.w500),
                      );
                      }
                  ),

                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Preferred Partners",
                    style: FontStyle.PoppinsStyle(16, Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return PartnersCard();
                          },
                          separatorBuilder: (context, i) => SizedBox(
                                width: 12,
                              ),
                          itemCount: 10))
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
}
