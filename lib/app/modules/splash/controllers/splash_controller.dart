import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxString name = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    bool isRemember = Db.auth.getRemeber();
    Map<String, dynamic>? user = Db.auth.getUser();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Get.offAllNamed(Routes.LOGIN);
          },
        );
      } else {
        if (!isRemember) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Get.offAllNamed(Routes.LOGIN);
            },
          );
        } else {
          Get.offAllNamed(Routes.DASHBOARD);
        }
      }
    });
  }
}
