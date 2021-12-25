import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/announcements/controller/announcement_controller.dart';
import 'package:happiness_club/widgets/customAppBar.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:happiness_club/constants/fontStyles.dart';


class AnnouncementDetailsScreen extends StatefulWidget {
  String id;
  AnnouncementDetailsScreen({required this.id});

  @override
  _AnnouncementDetailsScreenState createState() => _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen> {

  String? htmlData ;
  bool loaded = false;
  loadData(){
    getAnnouncementsById(widget.id).then((value) {
      if(value!=null){
        setState(() {
          loaded = true;
          htmlData ="""${value.data!.first!.description}""";
        });
      }
      else{
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(
            child: SvgPicture.asset(Images.BACK_BUTTON,height: 15,),
          ),
        ),
        title: Text("Announcements Detail",style: FontStyle.PoppinsStyle(17, Colors.black,
            fontWeight: FontWeight.w600),),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
             // CustomAppBar(title: "Announcements Detail"),
             loaded? htmlData!=null? Html(
                data: htmlData,
              ):Center(child: Text("No details found")): Center(
               child: getLoader(),
             )
            ],
          ),
        ),
      ),
    );
  }
}
