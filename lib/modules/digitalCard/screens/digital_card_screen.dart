import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/auth/Screens/help_customer_screen.dart';
import 'package:happiness_club/modules/digitalCard/Controller/digital_card_controller.dart';
import 'package:happiness_club/modules/digitalCard/Model/digital_card_model.dart';
import 'package:happiness_club/modules/digitalCard/widget/digital_card_widget.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';

class DigitalCardScreen extends StatefulWidget {
  const DigitalCardScreen({Key? key}) : super(key: key);

  @override
  _DigitalCardScreenState createState() => _DigitalCardScreenState();
}

class _DigitalCardScreenState extends State<DigitalCardScreen> {
  Uint8List? imageBlob;
  List<Widget> blobList = [];
  List<Uint8List> fazaCard = [];
  List<Uint8List> hpcCard = [];

  bool loaded = false;

  loadData() {
    getDigitalCards(context).then((DigitalCardsModel? value) {
      //print(value);
      if (value != null) {
        setState(() {
          for (int i = 0; i < value.data.fazaaCard.length; i++) {
            // fazaCard.add(base64.decode(value.data.fazaaCard[i].front.split(',').last));
            // fazaCard.add(base64.decode(value.data.fazaaCard[i].back.split(',').last));
            blobList.add(DigitalCardWidget(
                front: base64
                    .decode(value.data.fazaaCard[i].front.split(',').last),
                back: base64
                    .decode(value.data.fazaaCard[i].back.split(',').last)));
          }

          for (int i = 0; i < value.data.happinessCard.length; i++) {
            blobList.add(DigitalCardWidget(
                front: base64
                    .decode(value.data.happinessCard[i].front.split(',').last),
                back: base64
                    .decode(value.data.happinessCard[i].back.split(',').last)));
          }
          loaded = true;
        });
      } else {
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
      appBar: CustomAppBar(
        title: LocaleKeys.digital_card.tr(),
        actions: [
          SizedBox(
            width: 50,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => HelpCustomerScreen()));
                },
                child: Text(
                  LocaleKeys.report_card.tr(),
                  style: FontStyles.PoppinsStyle(
                      8, Color(ColorCodes.GOLDEN_COLOR),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
      body: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              height: size.height,
              width: constraints.maxWidth < 600 ? size.width : 400,
              child: loaded
                  ? blobList.isNotEmpty
                      ? Center(
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              itemBuilder: (context, i) => blobList[i],
                              separatorBuilder: (context, i) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount: blobList.length),
                        )
                      : Center(child: Text(LocaleKeys.no_card_found.tr()))
                  : Center(
                      child: getLoader(),
                    ),
            ),
          );
        },
      )),
    );
  }
}
