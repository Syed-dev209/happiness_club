import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:io' show Platform;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/images.dart';


class PdfViewScreen extends StatelessWidget {
  String pdfUrl;
  PdfViewScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(pdfUrl);
    //print(url.hasAbsolutePath);
   // print(url.origin+url.path);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(child: SvgPicture.asset(Images.BACK_BUTTON,height: 15,)) ,
        ),
      ),
      body: const PDF().fromUrl(
        url.origin+url.path,
        placeholder: (double progress) => loader(),
        errorWidget: (dynamic error) => Center(child: Text("Unable to load newsletter.")),
      ),
    );
  }

  loader(){
    return Center(child: Platform.isAndroid?CircularProgressIndicator():CupertinoActivityIndicator());
  }
}
