import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Controller/offers_controller.dart';
import 'package:happiness_club/modules/offers/Widget/offer_card_shimmer.dart';
import 'package:happiness_club/modules/offers/Widget/offersCard.dart';
import 'package:happiness_club/widgets/customAppBar.dart';


class OffersByCategoryScreen extends StatefulWidget {
  String catId, catName;
  OffersByCategoryScreen({required this.catId, required this.catName});

  @override
  _OffersByCategoryScreenState createState() => _OffersByCategoryScreenState();
}

class _OffersByCategoryScreenState extends State<OffersByCategoryScreen> {
  StreamController<OffersModel?>? offerStreamController;

  loadData()async{
    getOffersByCategory(catId: widget.catId).then((value) {
      if(value!=null){
        offerStreamController!.add(value);
        return value;
      }
      else{
        offerStreamController!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerStreamController = StreamController<OffersModel?>();
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
                child: CustomAppBar(title: "${widget.catName}"),
              ),
              Expanded(
                child: StreamBuilder<OffersModel?>(
                  stream: offerStreamController!.stream,
                  builder: (context,snapshot){
                    if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                      return ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                          itemBuilder: (context,i){
                            return OfferCardShimmer();
                          }, separatorBuilder: (context,i)=>SizedBox(height: 15,),
                          itemCount: 3
                      );
                    }
                    if(snapshot.data == null){
                      return Text("No offers found");
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                     itemBuilder: (context,i){
                      return OffersCard(modelData: snapshot.data!.data![i]!,);
                    }, separatorBuilder: (context,i)=>SizedBox(height: 15,),
                        itemCount: snapshot.data!.data!.length
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
