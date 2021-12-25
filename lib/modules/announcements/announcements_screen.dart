import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/modules/announcements/Model/announcement_model.dart';
import 'package:happiness_club/modules/announcements/announcement_details_screen.dart';
import 'package:happiness_club/modules/announcements/controller/announcement_controller.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:html/parser.dart' as htmlparser;


class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {

  StreamController<AnnouncementModel?>? streamController;
  loadData(){
    getAnnouncements().then((value) {
      if(value!=null){
        streamController!.add(value);
        return value;
      }
      else{
        streamController!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController<AnnouncementModel?>();
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
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Column(
            children: [
              CustomAppBar(title: "Announcement"),
              Expanded(
                  child: StreamBuilder<AnnouncementModel?>(
                    stream: streamController!.stream,
                    builder: (context,snapshot){

                      if(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: getLoader(),
                        );
                      }
                      if(snapshot.data == null){
                        return Center(
                          child: Text("No announcements"),
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          itemBuilder: (context,i)=>announcementCard(snapshot.data!.data![i]!),
                          separatorBuilder: (context,i)=>SizedBox(height: 15,),
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


  announcementCard(AnnouncementModelData data){
    String htmlData = """${data.description}""";
    return Container(
      height: 122,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0,0.5),
        //     color: Colors.black26,
        //     spreadRadius: 0.1,
        //     blurRadius: 0.1
        //   )
        // ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${data.title}",style: FontStyle.PoppinsStyle(14, Colors.black,fontWeight: FontWeight.w500),),
          SizedBox(height: 5,),
          Expanded(
              child: Html(
                shrinkWrap: true,
                  data: htmlData,
                style: {
                    "p":Style(
                      textOverflow: TextOverflow.fade
                    )
                },
              )
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (_)=>AnnouncementDetailsScreen(id: data.id!.toString())));
            },
              child: Text(
                "Read More...",
                style: FontStyle.PoppinsStyle(
                    12, Color(ColorCodes.BLUE_COLOR),
                    fontWeight: FontWeight.w500),
              )
          )
        ],
      ),
    );
  }
}
