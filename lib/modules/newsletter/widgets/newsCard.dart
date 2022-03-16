import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/newsletter/Model/newsletter_model.dart';
import 'package:happiness_club/modules/newsletter/Screens/PdfViewScreen.dart';


class NewsCard extends StatelessWidget {
  NewsletterModelData modelData;
  NewsCard({required this.modelData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>PdfViewScreen(pdfUrl: modelData.pdfFileName!)));
      },
      child: Stack(
        children: [
          Container(
            height: 220,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 10),
            foregroundDecoration:BoxDecoration(
               borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent,Colors.black.withOpacity(0.55)]
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: CachedNetworkImageProvider(modelData.imageFilename!),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
        padding: EdgeInsets.only(top: 90,left: 10),
         child: Text('${modelData.title}',style: FontStyles.PoppinsStyle(14, Colors.white),))
        ],
      ),
    );
  }

}