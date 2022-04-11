import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/modules/prizeHistory/controller/prize_history_controller.dart';
import 'package:happiness_club/modules/prizeHistory/model/prize_history_model.dart';
import 'package:happiness_club/modules/prizeHistory/widget/prize_history_card.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';

class PrizeHistoryScreen extends StatefulWidget {
  const PrizeHistoryScreen({Key? key}) : super(key: key);

  @override
  _PrizeHistoryScreenState createState() => _PrizeHistoryScreenState();
}

class _PrizeHistoryScreenState extends State<PrizeHistoryScreen> {

  late StreamController<PrizeHistoryModel?> streamController;
  loadData(){
    getPrizeHistory(context).then((value) {
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
    streamController = StreamController<PrizeHistoryModel?>();
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
          color: Colors.transparent,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustomAppBar(
                  title: LocaleKeys.prize_history.tr(),
                ),
              ),


              Expanded(
                child: StreamBuilder<PrizeHistoryModel?>(
                  stream:  streamController.stream,
                  builder: (context,snapshot){

                    if(snapshot.hasError || snapshot.connectionState ==ConnectionState.waiting){
                      return Center(
                        child: getLoader(),
                      );
                    }

                    if(snapshot.data == null){
                      return Center(
                        child: Text(LocaleKeys.no_prize_history_found.tr(),style: FontStyles.PoppinsStyle(17, Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold),),
                      );
                    }

                    return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                        itemBuilder: (context,i)=>PrizeHistoryCard(model: snapshot.data!.data![i]!,),
                        separatorBuilder: (context,i)=>SizedBox(height: 12,),
                        itemCount: snapshot.data!.data!.length
                    );
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
