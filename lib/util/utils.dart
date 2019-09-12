import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// function: Utils
/// <p>Created by Leo on 2019/5/8.</p>

class Utils {
  /// 提示暂未开放
  static void showWaiting(GlobalKey<ScaffoldState> _scaffoldkey) {
    final snackBar = new SnackBar(
      content: new Text('暂未开放，敬请期待...', style: new TextStyle(color: Colors.white, fontSize: 15)),
      duration: new Duration(seconds: 1),
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  static void toastWait() {
    toast('暂未开放，敬请期待');
  }

  //toast
  static void toast(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
