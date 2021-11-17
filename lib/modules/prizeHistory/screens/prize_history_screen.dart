import 'package:flutter/material.dart';
import 'package:happiness_club/modules/prizeHistory/widget/prize_history_card.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class PrizeHistoryScreen extends StatefulWidget {
  const PrizeHistoryScreen({Key? key}) : super(key: key);

  @override
  _PrizeHistoryScreenState createState() => _PrizeHistoryScreenState();
}

class _PrizeHistoryScreenState extends State<PrizeHistoryScreen> {
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
                  title: "Prize History",
                ),
              ),


              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  itemBuilder: (context,i)=>PrizeHistoryCard(), 
                  separatorBuilder: (context,i)=>SizedBox(height: 12,), 
                  itemCount: 10
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
