import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Profile"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              top: 10,
            ),
            child: Row(
              children: [
                Utils.appButton.backButton(
                  buttonColor: AppColors.primary,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            children: [
              boxHeight(20),
              Obx(
                () => profileImage(controller.image.value, () {
                  // uploadImage(
                  //   "Edit Profile Image",
                  //   (image) => controller.changeProfileImage(image),
                  // );
                }, updateImage: controller.updateProfile.value),
              ),
              boxHeight(10),
              boxHeight(20),
              TextFormField(
                controller: controller.firstName,
                decoration: Utils.appDecorations.inputDecoration2("First name"),
              ),
              boxHeight(10),
              TextFormField(
                controller: controller.lastName,
                decoration: Utils.appDecorations.inputDecoration2("Last name"),
              ),
              boxHeight(10),
              TextFormField(
                readOnly: true,
                controller: controller.phone,
                decoration:
                    Utils.appDecorations.inputDecoration2("Phone number"),
              ),
              boxHeight(10),
              TextFormField(
                controller: controller.email,
                decoration: Utils.appDecorations.inputDecoration2("Email id"),
              ),
              boxHeight(10),
              TextFormField(
                minLines: 3,
                maxLines: null,
                controller: controller.address,
                decoration:
                    Utils.appDecorations.inputDecoration2("Address").copyWith(
                          contentPadding: const EdgeInsets.all(10),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
