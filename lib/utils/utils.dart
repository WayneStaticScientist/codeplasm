import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void to(BuildContext context, Widget parent) {}
  static void showToast(String message, {bool error = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: error ? Colors.red : Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
