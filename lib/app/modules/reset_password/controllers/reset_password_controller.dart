import 'dart:developer';

import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  RxBool loadingButton = false.obs;
  RxBool newPassBool = true.obs;
  RxBool conPassBool = true.obs;

  TextEditingController newPassCon = TextEditingController();
  TextEditingController conPassCon = TextEditingController();

  Future<void> onResePassword() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        if (newPassCon.text == "") {
          AppToast.showSnakeBar("Please enter new password");
        } else if (conPassCon.text == "") {
          AppToast.showSnakeBar("Please enter confirm password");
        } else if (newPassCon.text != conPassCon.text) {
          AppToast.showSnakeBar("Please enter same password");
        } else {
          loadingButton.value = true;
          Map<String, dynamic>? user = Db.auth.getUser();
          Map<String, dynamic> body = {
            "user_id": user!['user_id'],
            "password": newPassCon.text,
          };
          Map<String, dynamic> response = await DioClient.postMethod(
            url: WebService.auth.resetPassword,
            body: body,
          );
          if (response['status'] == 200) {
            AppToast.showSnakeBar("Reset password successfully");
            Get.toNamed(Routes.LOGIN);
          } else {
            AppToast.showToast(response['message']);
          }
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
