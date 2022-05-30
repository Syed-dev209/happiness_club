import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:happiness_club/constants/network_constants.dart';
import 'package:happiness_club/modules/auth/Controller/auth_controller.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class UaePassLoginScreen extends StatefulWidget {
  const UaePassLoginScreen({Key? key}) : super(key: key);

  @override
  _UaePassLoginScreenState createState() => _UaePassLoginScreenState();
}

class _UaePassLoginScreenState extends State<UaePassLoginScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
          supportZoom: false,
          disableHorizontalScroll: true,
          verticalScrollBarEnabled: false
          // disableVerticalScroll: true,
          ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
    
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Login with UAE-PASS',
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest:
                    URLRequest(url: Uri.parse(APIS.UAE_PASS_URL)),
                initialOptions: options,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {},
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
                onLoadStop: (controller, uri) async {
                  print("On load end triggered");
                  //if (uri!.data.toString().contains('/recon?')) {
                  // if JavaScript is enabled, you can use
                  var html = await webViewController!.evaluateJavascript(
                      source: "window.document.body.innerText;");
                  print("HTMl==>");
                  print(html);
                  String input = html.toString().substring(0, 7);
                  print(input);
                  if (input == "{\"sub\":") {
                    print("user found");
                    loginWithUaePass(context, html.toString());
                    //Navigator.pop(context);
                  }
                  //}
                },
              ),
              progress < 1.0
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(value: progress))
                  : Container(),
              // IconButton(onPressed: ()async{
              //   var html = await webViewController!.evaluateJavascript(
              //       source: "window.document.body.innerText;");
              //   print("HTMl==>");
              //   print(html);
              // }, icon: Icon(Icons.eleven_mp))
            ],
          ),
        ),
      ),
    );
  }
}
