import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ExitAppAlert {
//show alert for exit app
  Future<bool> onBackPress({BuildContext context}) {
    _onWillPop(context);
    return Future.value(false);
  }

  Future<Null> _onWillPop(context) {
    return Alert(
      context: context,
      style: AlertStyle(
        isCloseButton: false,
        isOverlayTapDismiss: true,
        animationType: AnimationType.fromRight,
        backgroundColor: Colors.white,
        descStyle: TextStyle(
          color: Colors.black,
        ),
        titleStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      type: AlertType.none,
      title: "EXIT APP",
      desc: "Are you sure you want to exit?",
      buttons: [
        DialogButton(
          color: Colors.black12,
          child: Text(
            "No",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          width: 120,
        ),
        DialogButton(
          color: Colors.black26,
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          onPressed: () => exit(0),
          width: 120,
        ),
      ],
    ).show();
  }
}
