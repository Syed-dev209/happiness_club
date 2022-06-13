import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/services/navigatorKey.dart';

getSuccessPopup({String text = "Successfully Subscribed"}) {
  CoolAlert.show(
      title: "Success!",
      loopAnimation: false,
      backgroundColor: Colors.white,
      context: GlobalVariable.navState.currentContext!,
      type: CoolAlertType.success,
      text: text,
      confirmBtnColor: Color(ColorCodes.GOLDEN_COLOR),
      onConfirmBtnTap: () {
        Navigator.pop(GlobalVariable.navState.currentContext!);
      });
}

getErrorPopup({String text = "Unable to Subscribe"}) {
  CoolAlert.show(
      backgroundColor: Colors.white,
      context: GlobalVariable.navState.currentContext!,
      type: CoolAlertType.info,
      title: 'Information!',
      text: text,
      confirmBtnColor: Color(ColorCodes.GOLDEN_COLOR),
      loopAnimation: false,
      onConfirmBtnTap: () {
        Navigator.pop(GlobalVariable.navState.currentContext!);
      });
}
