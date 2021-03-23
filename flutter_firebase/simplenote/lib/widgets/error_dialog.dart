import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, Exception e) {
  String errorTitle;
  String errorPlugin;
  String errorMessage;

  // FirebaseException : 파이어베이스 에러
  if (e is FirebaseException) {
    errorTitle = e.code;
    errorMessage = e.message;
    errorPlugin = e.plugin;
  } else {
    errorTitle = 'Exception';
    errorPlugin = 'flutter_error/server_error';
    errorMessage = e.toString();
  }

  if (Platform.isIOS) {
    // 현재 프레임이 끝나고 다이어로그 알림을 띄움
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(errorTitle),
              content: Text(errorPlugin + '\n' + errorMessage),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(errorTitle),
              content: Text(errorPlugin + '\n' + errorMessage),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    });
  }
}
