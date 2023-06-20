import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/utils/app_toast.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Edit Profile"),
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
                  uploadImage(
                    "Edit Profile Image",
                    (image) => controller.changeProfileImage(image),
                  );
                }, updateImage: controller.updateProfile.value),
              ),
              boxHeight(10),
              Obx(
                () => Row(
                  children: [
                    controller.updateProfile.value == null
                        ? const Spacer()
                        : const SizedBox(),
                    controller.updateProfile.value == null
                        ? ElevatedButton(
                            onPressed: () {
                              uploadImage(
                                "Edit Profile Image",
                                (image) => controller.changeProfileImage(image),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.edit_outlined),
                                boxWidth(10),
                                const Text("Edit Image"),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                uploadImage(
                                  "Edit Profile Image",
                                  (image) =>
                                      controller.changeProfileImage(image),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.edit_outlined),
                                  boxWidth(10),
                                  const Text("Edit Image"),
                                ],
                              ),
                            ),
                          ),
                    controller.updateProfile.value == null
                        ? const SizedBox()
                        : boxWidth(10),
                    controller.updateProfile.value == null
                        ? const SizedBox()
                        : Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                color: AppColors.lightBlack,
                              )),
                              child: Text(
                                'Clean Image',
                                style: TextStyle(color: AppColors.lightBlack),
                              ),
                              onPressed: () {
                                controller.clear();
                              },
                            ),
                          ),
                    controller.updateProfile.value == null
                        ? const Spacer()
                        : const SizedBox(),
                  ],
                ),
              ),
              boxHeight(20),
              TextFormField(
                controller: controller.firstName,
                decoration:
                    Utils.appDecorations.inputDecoration2("Enter first name"),
              ),
              boxHeight(10),
              TextFormField(
                controller: controller.lastName,
                decoration:
                    Utils.appDecorations.inputDecoration2("Enter last name"),
              ),
              boxHeight(10),
              TextFormField(
                readOnly: true,
                controller: controller.phone,
                decoration:
                    Utils.appDecorations.inputDecoration2("Enter phone number"),
                onTap: () {
                  AppToast.showSnakeBar("Phone number is not editable");
                },
              ),
              boxHeight(10),
              TextFormField(
                controller: controller.email,
                decoration:
                    Utils.appDecorations.inputDecoration2("Enter email id"),
              ),
              boxHeight(10),
              TextFormField(
                minLines: 3,
                maxLines: null,
                controller: controller.address,
                decoration: Utils.appDecorations
                    .inputDecoration2("Enter address")
                    .copyWith(
                      contentPadding: const EdgeInsets.all(10),
                    ),
              ),
              boxHeight(30),
              Obx(
                () => Utils.appButton.primaryButton(
                  loading: controller.buttonLoading.value,
                  child: const Text('Save'),
                  onPress: () {
                    controller.onSave();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
