import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:io' show Platform;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class PdfViewScreen extends StatelessWidget {
  String pdfUrl;
  PdfViewScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(pdfUrl);
    final provider = Provider.of<UserModelProvider>(context, listen: false);
    //print(url.hasAbsolutePath);
    // print(url.origin+url.path);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
              child: RotatedBox(
            quarterTurns: provider.language == 0 ? 0 : 2,
            child: SvgPicture.asset(
              Images.BACK_BUTTON,
              height: 20,
              width: 20,
            ),
          )),
        ),
        leadingWidth: 25,
      ),
      body: const PDF().fromUrl(
        url.origin + url.path,
        placeholder: (double progress) => loader(),
        errorWidget: (dynamic error) =>
            Center(child: Text(LocaleKeys.unable_to_load_newsletter.tr())),
      ),
    );
  }

  loader() {
    return Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator());
  }
}
