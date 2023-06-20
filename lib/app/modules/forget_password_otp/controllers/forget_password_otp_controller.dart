import 'dart:developer';

import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordOtpController extends GetxController {
  RxBool loadingButton = false.obs;
  TextEditingController otpCon = TextEditingController();

  Future<void> onVerify() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (otpCon.text.length != 4) {
          AppToast.showToast("Please enter valid otp");
        } else {
          loadingButton.value = true;
          Map<String, dynamic> body = {
            "mobile_no": Db.auth.getForgetMobile(),
            "otp": int.parse(otpCon.text),
          };
          Map<String, dynamic> response = await DioClient.postMethod(
            url: WebService.auth.verifyOtp,
            body: body,
          );
          if (response['status'] == 200) {
            Db.auth.setUserId(int.parse(response['data']['user_id']));
            Get.toNamed(Routes.RESET_PASSWORD);
          } else {
            AppToast.showToast(response['message']);
          }
          loadingButton.value = false;
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
