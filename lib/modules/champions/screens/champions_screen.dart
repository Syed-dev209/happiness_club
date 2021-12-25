import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/modules/champions/Controller/champions_controller.dart';
import 'package:happiness_club/modules/champions/Model/champions_model.dart';
import 'package:happiness_club/modules/champions/widgets/champions_card.dart';
import 'package:happiness_club/modules/champions/widgets/champions_card_shimmer.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class ChampionsScreen extends StatefulWidget {
  const ChampionsScreen({Key? key}) : super(key: key);

  @override
  _ChampionsScreenState createState() => _ChampionsScreenState();
}

class _ChampionsScreenState extends State<ChampionsScreen> {

  StreamController<ChampionsModel?>? championsController;
  loadData()async{
    getChampions(context).then((value) {
      if(value!=null){
        championsController!.add(value);
        return value;
      }
      else{
        championsController!.add(null);
        return null;
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    championsController = StreamController<ChampionsModel?>();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    championsController!.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
          child:Column(
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomAppBar(title: "Champions"),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder<ChampionsModel?>(
                  stream: championsController!.stream,
                  builder: (context,snapshot){
                    if(snapshot.hasError || !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return RefreshIndicator(
                        onRefresh: ()async{
                          loadData();
                        },
                        child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                            itemBuilder: (context,i)=>ChampionsCardShimmer(),
                            separatorBuilder: (context,i)=>SizedBox(height: 12,),
                            itemCount: 3
                        ),
                      );
                    }
                    if(snapshot.data == null){
                      return Text("No champions found");
                    }

                    ChampionsModel model = snapshot.data!;
                    return RefreshIndicator(
                      onRefresh: ()async{
                        loadData();
                      },
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                          itemBuilder: (context,i)=>ChampionsCard(modelData: model.data![i]!,),
                          separatorBuilder: (context,i)=>SizedBox(height: 12,),
                          itemCount: model.data!.length
                      ),
                    );
                  },
                )

              )
            ]
          ),
        ),
      ),
    );
  }
}
