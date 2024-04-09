import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppFunctions {
  toastFun({required String data, bool positive = false}) {
    Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: positive ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
