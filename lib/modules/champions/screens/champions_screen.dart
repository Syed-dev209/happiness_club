import 'package:flutter/material.dart';
import 'package:happiness_club/modules/champions/widgets/champions_card.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class ChampionsScreen extends StatefulWidget {
  const ChampionsScreen({Key? key}) : super(key: key);

  @override
  _ChampionsScreenState createState() => _ChampionsScreenState();
}

class _ChampionsScreenState extends State<ChampionsScreen> {
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
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  itemBuilder: (context,i)=>ChampionsCard(), 
                  separatorBuilder: (context,i)=>SizedBox(height: 12,), 
                  itemCount: 10
                  ) 
              )
            ]
          ),
        ),
      ),
    );
  }
}
