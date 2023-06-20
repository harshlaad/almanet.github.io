import 'dart:developer';

import 'package:app/services/local_db/local_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
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
}
