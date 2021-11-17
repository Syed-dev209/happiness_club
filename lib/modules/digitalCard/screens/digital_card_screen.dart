import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/digitalCard/widget/digital_card_widget.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class DigitalCardScreen extends StatefulWidget {
  const DigitalCardScreen({Key? key}) : super(key: key);

  @override
  _DigitalCardScreenState createState() => _DigitalCardScreenState();
}

class _DigitalCardScreenState extends State<DigitalCardScreen> {
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
              Expanded(
                child: Stack(
                  children: [
                    ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        itemBuilder: (context, i) => DigitalCardWidget(),
                        separatorBuilder: (context, i) => SizedBox(
                              height: 15,
                            ),
                        itemCount: 6),
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
                            onPressed: () {}, 
                            child: Text("Report a card",
                            style: FontStyle.PoppinsStyle(16, Colors.white,fontWeight: FontWeight.w600),
                           )
                          ),
                        )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
