import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'const/color_utils.dart';
import 'const/font_size_utils.dart';
import 'localization/localization.dart';

class DialogUtils {
  static void showOkCancelAlertDialog({
    BuildContext context,
    String message,
    String okButtonTitle,
    String cancelButtonTitle,
    Function cancelButtonAction,
    Function okButtonAction,
    bool isCancelEnable = true,
  }) {
    // flutter defined function
    showDialog(
      barrierDismissible: isCancelEnable,
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return _showOkCancelCupertinoAlertDialog(
              context,
              message,
              okButtonTitle,
              cancelButtonTitle,
              okButtonAction,
              isCancelEnable,
              cancelButtonAction);
        } else {
          return _showOkCancelMaterialAlertDialog(
              context,
              message,
              okButtonTitle,
              cancelButtonTitle,
              okButtonAction,
              isCancelEnable,
              cancelButtonAction);
        }
      },
    );
  }

  static void showAlertDialog(BuildContext context, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return _showCupertinoAlertDialog(context, message);
        } else {
          return _showMaterialAlertDialog(context, message);
        }
      },
    );
  }

  static void showAlertDialogWithCustomeAction(BuildContext context, String message,List<Widget> actions) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return _showCupertinoAlertDialog(context, message,actions: actions);
        } else {
          return _showMaterialAlertDialog(context, message,actions: actions);
        }
      },
    );
  }

  static CupertinoAlertDialog _showCupertinoAlertDialog(
      BuildContext context, String message,{List<Widget> actions}) {
    return CupertinoAlertDialog(
      title: Text(Localization.of(context).appName),
      content: Text(message),
      actions: actions == null?_actions(context):actions,
    );
  }

  static AlertDialog _showMaterialAlertDialog(
      BuildContext context, String message,{List<Widget> actions}) {
    return AlertDialog(
      title: Text(Localization.of(context).appName),
      content: Text(message,style: TextStyle(color: Colors.black),),
      actions:actions == null? _actions(context):actions,
    );
  }

  static AlertDialog _showOkCancelMaterialAlertDialog(
      BuildContext context,
      String message,
      String okButtonTitle,
      String cancelButtonTitle,
      Function okButtonAction,
      bool isCancelEnable,
      Function cancelButtonAction) {
    return AlertDialog(
      title: Text(Localization.of(context).appName),
      content: Text(message),
      actions: _okCancelActions(
        context: context,
        okButtonTitle: okButtonTitle,
        cancelButtonTitle: cancelButtonTitle,
        okButtonAction: okButtonAction,
        isCancelEnable: isCancelEnable,
        cancelButtonAction: cancelButtonAction,
      ),
    );
  }

  static CupertinoAlertDialog _showOkCancelCupertinoAlertDialog(
    BuildContext context,
    String message,
    String okButtonTitle,
    String cancelButtonTitle,
    Function okButtonAction,
    bool isCancelEnable,
    Function cancelButtonAction,
  ) {
    return CupertinoAlertDialog(
        title: Text(Localization.of(context).appName),
        content: Text(message),
        actions: isCancelEnable
            ? _okCancelActions(
                context: context,
                okButtonTitle: okButtonTitle,
                cancelButtonTitle: cancelButtonTitle,
                okButtonAction: okButtonAction,
                isCancelEnable: isCancelEnable,
                cancelButtonAction: cancelButtonAction,
              )
            : _okAction(
                context: context,
                okButtonAction: okButtonAction,
                okButtonTitle: okButtonTitle));
  }

  static List<Widget> _actions(BuildContext context) {
    return <Widget>[
      Platform.isIOS
          ? CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
    ];
  }

  static List<Widget> _okCancelActions({
    BuildContext context,
    String okButtonTitle,
    String cancelButtonTitle,
    Function okButtonAction,
    bool isCancelEnable,
    Function cancelButtonAction,
  }) {
    return <Widget>[
      cancelButtonTitle != null
          ? Platform.isIOS
              ? CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text(cancelButtonTitle),
                  onPressed: cancelButtonAction == null
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : () {
                          Navigator.of(context).pop();
                          cancelButtonAction();
                        },
                )
              : FlatButton(
                  child: Text(cancelButtonTitle),
                  onPressed: cancelButtonAction == null
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : () {
                          Navigator.of(context).pop();
                          cancelButtonAction();
                        },
                )
          : null,
      Platform.isIOS
          ? CupertinoDialogAction(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
                okButtonAction();
              },
            )
          : FlatButton(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
                okButtonAction();
              },
            ),
    ];
  }

  static List<Widget> _okAction(
      {BuildContext context, String okButtonTitle, Function okButtonAction}) {
    return <Widget>[
      Platform.isIOS
          ? CupertinoDialogAction(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
                okButtonAction();
              },
            )
          : FlatButton(
              child: Text(okButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
                okButtonAction();
              },
            ),
    ];
  }

  static Future<bool> displayToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: fontSize14,

    );
  }

  static SnackBar displaySnackBar({String message}) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize14,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: primaryColor,
    );
  }
}
