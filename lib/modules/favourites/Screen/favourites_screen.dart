import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/favourites/Widget/favourites_card.dart';
import 'package:happiness_club/modules/favourites/controller/favorites_controller.dart';
import 'package:happiness_club/modules/favourites/model/favorites_model.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:provider/provider.dart';


class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  StreamController<FavoritesModel?>? controller;
  loadData(){
    if(Provider.of<UserModelProvider>(context,listen: false).loggedIn) {
      getFavoritesList(context).then((value) {
        print("DATA==>$value");
        if (value != null) {
          controller!.add(value);
          return value;
        }
        else {
          controller!.add(null);
          return null;
        }
      });
    }
    else {
      Future.delayed(Duration(seconds: 2)).then((value) {
        controller!.add(null);
        showToast(context, "You must login to see favorites");
        return null;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = StreamController<FavoritesModel?>.broadcast();
    //loadData();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //loadData();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 13,vertical: 8),
          child: Column(
            children: [
              CustomAppBar(title: "Favourites"),
              Expanded(
                  child: StreamBuilder<FavoritesModel?>(
                    stream: controller!.stream,
                    builder: (context,snapshot){
                      print(snapshot.data);

                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: getLoader(),
                        );
                      }
                      if(snapshot.data == null){
                        return Center(
                            child: noDataFound()
                        );
                      }
                      return snapshot.data!.data!.isNotEmpty?ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                          itemBuilder: (context,i){
                            return FavouritesCard(modelData:snapshot.data!.data![i]!,reload: (){
                              loadData();
                            },);
                          },
                          separatorBuilder: (context,i)=>SizedBox(height: 12,),
                          itemCount: snapshot.data!.data!.length
                      ):Center(
                        child: noDataFound()
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

  noDataFound(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Images.NO_DATA),
        SizedBox(height: 15,),
        Text(
          "No favourites marked",
          style: FontStyle.PoppinsStyle(
              15,
              Color(ColorCodes.GOLDEN_COLOR).withOpacity(0.4),
              fontWeight: FontWeight.w600),)
      ],
    );
  }
}
