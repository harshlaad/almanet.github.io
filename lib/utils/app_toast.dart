import 'package:app/app/app_config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppToast {
  static showToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.7),
      fontSize: 12.sp,
    );
  }

  static showSnakeBar(String msg, {Duration? duration}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
      duration: duration ?? const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      snackBar,
    );
  }
}
