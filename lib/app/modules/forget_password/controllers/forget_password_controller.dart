import 'dart:developer';

import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool check = false.obs;
  RxBool buttonLoading = false.obs;

  TextEditingController phoneCon = TextEditingController();

  Future<void> onContinue() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (phoneCon.text == "" || !GetUtils.isPhoneNumber(phoneCon.text)) {
          AppToast.showToast("Please enter valid mobile number");
        } else {
          buttonLoading.value = true;
          Map<String, dynamic> body = {
            "mobile_no": int.parse(phoneCon.text),
          };
          Map<String, dynamic> response = await DioClient.postMethod(
            url: WebService.auth.forgetPassword,
            body: body,
          );
          log(response.toString());
          if (response['status'] == 200) {
            Db.auth.setforgetMobile(phoneCon.text);
            Get.toNamed(Routes.FORGET_PASSWORD_OTP);
          } else {
            AppToast.showToast(response['message']);
          }
          buttonLoading.value = false;
        }
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
