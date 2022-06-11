import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/services/navigatorKey.dart';

getSuccessPopup({String text = "Successfully Subscribed"}) {
  CoolAlert.show(
      context: GlobalVariable.navState.currentContext!,
      type: CoolAlertType.success,
      text: text,
      autoCloseDuration: Duration(seconds: 2),
      onConfirmBtnTap: () {
        Navigator.pop(GlobalVariable.navState.currentContext!);
      });
}

getErrorPopup({String text = "Unable to Subscribe"}) {
  CoolAlert.show(
      context: GlobalVariable.navState.currentContext!,
      type: CoolAlertType.error,
      title: 'Oops...',
      text: text,
      loopAnimation: false,
      onConfirmBtnTap: () {
        Navigator.pop(GlobalVariable.navState.currentContext!);
      });
}
