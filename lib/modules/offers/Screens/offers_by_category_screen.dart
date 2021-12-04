import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerStreamController = StreamController<OffersModel?>();
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
              CustomAppBar(title: "${widget.catName}"),
              Expanded(
                child: StreamBuilder<OffersModel?>(
                  stream: offerStreamController!.stream,
                  builder: (context,snapshot){

                    if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.data == null){
                      return Text("No offers found");
                    }

                    return ListView.separated(
                     itemBuilder: (context,i){
                      return OffersCard();
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
