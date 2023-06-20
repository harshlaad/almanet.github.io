import 'dart:developer';
import 'dart:io';

import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool check = false.obs;
  RxBool isShowPass = false.obs;
  RxBool buttonLoading = false.obs;

  TextEditingController phoneCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  Future<void> onLogin() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (phoneCon.text == "" || !GetUtils.isPhoneNumber(phoneCon.text)) {
          AppToast.showSnakeBar("Please enter valid mobile number");
        } else if (passCon.text == "") {
          AppToast.showSnakeBar("Please enter password");
        } else {
          buttonLoading.value = true;
          int deviceType = 0;
          if (Platform.isAndroid) {
            deviceType = 1;
          } else if (Platform.isIOS) {
            deviceType = 2;
          }
          String? token = await FirebaseMessaging.instance.getToken();
          Map<String, dynamic> body = {
            "mobile_no": phoneCon.text,
            "password": passCon.text,
            "device_type": deviceType,
            "device_token": token
          };
          Map<String, dynamic> response = await DioClient.postMethod(
            url: WebService.auth.login,
            body: body,
          );
          log(response.toString());
          if (response['status'] == 200) {
            Db.auth.setUser(response['data']);
            Db.auth.setRemeber(check.value);
            Get.offAndToNamed(Routes.DASHBOARD);
          } else {
            AppToast.showToast(response['message']);
          }
        }

        buttonLoading.value = false;
      },
    );
  }

  Future<void> getProfile() async {
    Map<String, dynamic> response =
        await DioClient.getMethod(url: WebService.auth.getProfile);
    log(response.toString());
    if (response['status']) {
      List list = response['result'];
      Db.auth.setProfile(list[0]);
    }
  }
}
