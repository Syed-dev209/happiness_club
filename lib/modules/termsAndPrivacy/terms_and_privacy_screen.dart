import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/termsAndPrivacy/terms_privacy_controller.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:shimmer/shimmer.dart';


class TermsAndPrivacyScreen extends StatefulWidget {
  String type;
  TermsAndPrivacyScreen({required this.type});

  @override
  _TermsAndPrivacyScreenState createState() => _TermsAndPrivacyScreenState();
}

class _TermsAndPrivacyScreenState extends State<TermsAndPrivacyScreen> {
  StreamController<String?>? streamController;

  loadData()async{
    getTermsAndPrivacy(widget.type).then((value){
      if(value!=null){
        streamController!.add(value);
        return value;
      }
      else{
        streamController!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController<String?>();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamController!.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              CustomAppBar(title: widget.type),
              Expanded(
                  child: SingleChildScrollView(
                child:  StreamBuilder<String?>(
                  stream: streamController!.stream,
                  builder: (context,snapshot){
                    if(snapshot.hasError || !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return textShimmer();
                    }
                    if(snapshot.data==null){
                      return Text("No ${widget.type} were found",style: FontStyles.PoppinsStyle(16, Colors.black26,fontWeight: FontWeight.w600),);
                    }
                    return Text("${snapshot.data}",
                      style: FontStyles.PoppinsStyle(14, Color(0xff7C86A2),
                          fontWeight: FontWeight.w500),);
                  },
                )

              ))
            ],
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
