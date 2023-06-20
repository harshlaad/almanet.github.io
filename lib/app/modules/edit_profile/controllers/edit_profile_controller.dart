import 'dart:developer';

import 'package:app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:app/app/modules/dashboard_drawer/controllers/dashboard_drawer_controller.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxString image = "".obs;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  Rxn<XFile> updateProfile = Rxn();
  RxBool buttonLoading = false.obs;

  @override
  void onInit() {
    Map<String, dynamic> user = Db.auth.getUser()!;
    firstName.text = user['first_name'] ?? "";
    lastName.text = user['last_name'] ?? "";
    phone.text = user['phone_no'];
    email.text = user['email'] ?? "";
    address.text = user['address'] ?? "";
    image.value = user['profile_image'] ?? "";

    log(user.toString());
    super.onInit();
  }

  void changeProfileImage(XFile image) {
    updateProfile.value = image;
  }

  void clear() {
    updateProfile.value = null;
  }

  Future<void> onSave() async {
    if (firstName.text == "") {
      AppToast.showSnakeBar("Please enter valid first  name");
    } else if (lastName.text == "") {
      AppToast.showSnakeBar("Please enter valid last name");
    } else if (email.text == "" || !GetUtils.isEmail(email.text)) {
      AppToast.showSnakeBar("Please enter valid email");
    } else if (address.text == "") {
      AppToast.showSnakeBar("Please enter address");
    } else {
      buttonLoading.value = true;
      Map<String, dynamic> user = Db.auth.getUser()!;
      Map<String, dynamic> body = updateProfile.value == null
          ? {
              "cab_driver_info_id": int.parse(user['cab_driver_info_id']),
              "name": firstName.text,
              "lastname": lastName.text,
              "address": address.text,
              "email": email.text,
            }
          : {
              "cab_driver_info_id": int.parse(user['cab_driver_info_id']),
              "name": firstName.text,
              "lastname": lastName.text,
              "address": address.text,
              "email": email.text,
              "profile_image":
                  await Utils.appWidgets.imageToMultipart(updateProfile.value!),
            };
      Map<String, dynamic> response = await DioClient.postMethodWithFormData(
        url: WebService.auth.updateProfile,
        body: body,
      );
      log(response.toString());

      log(response.toString());
      if (response['status'] == 200) {
        Db.auth.setUser(response['driver']);
        DashboardController dashboardController = Get.find();
        DashboardDrawerController dashboardDrawerController = Get.find();
        dashboardController.getUser();
        dashboardDrawerController.getUser();
        Get.back();
        AppToast.showSnakeBar("Profile Updated Successfully");
      } else {
        AppToast.showSnakeBar(response['message']);
      }
      buttonLoading.value = false;
    }
  }
}
