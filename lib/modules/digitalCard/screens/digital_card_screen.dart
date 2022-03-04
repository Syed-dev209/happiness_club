import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/auth/Screens/help_customer_screen.dart';
import 'package:happiness_club/modules/digitalCard/Controller/digital_card_controller.dart';
import 'package:happiness_club/modules/digitalCard/Model/digital_card_model.dart';
import 'package:happiness_club/modules/digitalCard/widget/digital_card_widget.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';

class DigitalCardScreen extends StatefulWidget {
  const DigitalCardScreen({Key? key}) : super(key: key);

  @override
  _DigitalCardScreenState createState() => _DigitalCardScreenState();
}

class _DigitalCardScreenState extends State<DigitalCardScreen> {

  Uint8List? imageBlob;
  List<Uint8List> blobList = [];
  bool loaded = false;

  loadData(){
    getDigitalCards(context).then((DigitalCardModel? value) {
      //print(value);
      if(value!=null){
        setState(() {
          for(int i=0;i< value.data!.fazaaCard!.length;i++){
            blobList.add(base64.decode(value.data!.fazaaCard![i]!.split(',').last));
            blobList.add(base64.decode(value.data!.happinessCard![i]!.split(',').last));
          }
         // imageBlob = base64.decode(value.split(',').last);
          loaded = true;
        });
      }
      else{
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustomAppBar(
                  title: "Digital Card",
                ),
              ),
             loaded?
             blobList.isNotEmpty?
            Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        itemBuilder: (context, i) => DigitalCardWidget(imageBlob: blobList[i],),
                        separatorBuilder: (context, i) => SizedBox(
                              height: 15,
                            ),
                        itemCount: blobList.length),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,left: 15,right: 15),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 58,
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(ColorCodes.GOLDEN_COLOR),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            onPressed: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>HelpCustomerScreen()));
                            },
                            child: Text("Report a card",
                            style: FontStyle.PoppinsStyle(16, Colors.white,fontWeight: FontWeight.w600),
                           )
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ):
            Expanded(child: Center(child: Text("No cards found")))
                :
             Expanded(
                child: Center(
                 child: getLoader(),
             ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
