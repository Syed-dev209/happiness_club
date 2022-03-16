import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/announcements/Model/announcement_model.dart';
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
  AnnouncementModelData? modelData;
  loadData(){
    getAnnouncementsById(widget.id).then((value) {
      if(value!=null){
        setState(() {
          loaded = true;
          htmlData ="""${value.description}""";
          modelData = value;
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
        title: Text("Announcements Detail",style: FontStyles.PoppinsStyle(17, Colors.black,
            fontWeight: FontWeight.w600),),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: SingleChildScrollView(
          child: loaded? Column(
            children: [
             // CustomAppBar(title: "Announcements Detail"),

              Center(
                child: Container(
                  height: 139,
                  width: 139,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(modelData!.imageUrl??Constants.NOT_FOUND_IMAGE_URL),
                      fit: BoxFit.fill
                    )
                  ),
                ),
              ),
             SizedBox(
               height: 15,
             ),
             Center(
               child: Text("${modelData!.title}",style: FontStyles.PoppinsStyle(20, Colors.black,fontWeight: FontWeight.w600),),
             ),
              htmlData!=null? Html(
                data: htmlData,
              ):Center(child: Text("No details found"))
            ],
          ): Center(
            child: getLoader(),
          ),
        ),
      ),
    );
  }
}
