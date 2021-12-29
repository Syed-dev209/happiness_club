import 'package:flutter/material.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/offers/Widget/offersCard.dart';
import 'package:happiness_club/widgets/customAppBar.dart';



class SearchResultsScreen extends StatefulWidget {
  OffersModel modelData;
  SearchResultsScreen({required this.modelData});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Column(
            children: [
              CustomAppBar(title: "Search Results"),
              Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      itemBuilder: (context,i){
                        return OffersCard(modelData: widget.modelData.data![i]!);
                      },
                      separatorBuilder: (context,i)=>SizedBox(height: 12,),
                      itemCount: widget.modelData.data!.length)
              )
            ],
          ),
        ),
      ),
    );
  }
}
