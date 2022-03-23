import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/LuckyDraw/Controller/luck_draw_controller.dart';
import 'package:happiness_club/modules/LuckyDraw/Model/lucky_draw_model.dart';
import 'package:happiness_club/modules/LuckyDraw/Widget/lucky_draw_event_card.dart';
import 'package:happiness_club/modules/offers/Widget/offer_card_shimmer.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';



class LuckyDrawScreen extends StatefulWidget {
  const LuckyDrawScreen({Key? key}) : super(key: key);

  @override
  _LuckyDrawScreenState createState() => _LuckyDrawScreenState();
}

class _LuckyDrawScreenState extends State<LuckyDrawScreen> {

  late StreamController<LuckDrawModel?> streamController;

  loadData(){
    getLuckDrawEvents(context).then((value){
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
    super.initState();
    streamController = StreamController<LuckDrawModel?>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomAppBar(title: 'Lucky Draw Events',),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child:StreamBuilder<LuckDrawModel?>(
            stream: streamController.stream,
            builder: (context,snapshot){
              if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      itemBuilder: (context,i)=> OfferCardShimmer(),
                      separatorBuilder: (context,i)=>SizedBox(height: 12,),
                      itemCount: 4
                  )
                );
              }

              if(snapshot.data ==null){
                return Center(
                  child: Text("Not Events were found",style: FontStyles.PoppinsStyle(17, Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold),),
                );
              }


              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  itemBuilder: (context,i)=> LuckyDrawEventCard(modelData: snapshot.data!.data![i]!),
                  separatorBuilder: (context,i)=>SizedBox(height: 12,),
                  itemCount: snapshot.data!.data!.length
              );
            },
          ) ,
        ),
      ),
    );
  }
}
