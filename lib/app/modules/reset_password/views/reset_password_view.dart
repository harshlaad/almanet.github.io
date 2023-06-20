import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            top: 5,
            bottom: 5,
          ),
          child: Utils.appButton.backButton(
            buttonColor: AppColors.primary,
            iconColor: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Assets.iconsc.logo.image(height: 70.h, width: 70.w),
            boxHeight(20),
            Container(
              margin: EdgeInsets.all(21.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create New Password",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Create your new password for Stargate so you can login to your account.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  boxHeight(20),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.newPassBool.value,
                      obscuringCharacter: "*",
                      controller: controller.newPassCon,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: Utils.appDecorations
                          .inputDecoration1(
                            "New Password",
                            GestureDetector(
                              onTap: () {
                                controller.newPassBool.value =
                                    !controller.newPassBool.value;
                              },
                              child: controller.newPassBool.value
                                  ? const Icon(
                                      Icons.visibility_outlined,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      size: 20,
                                    ),
                            ),
                          )
                          .copyWith(counterText: ""),
                    ),
                  ),
                  boxHeight(10),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.conPassBool.value,
                      obscuringCharacter: "*",
                      controller: controller.conPassCon,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: Utils.appDecorations.inputDecoration1(
                        "Confirm Password",
                        GestureDetector(
                          onTap: () {
                            controller.conPassBool.value =
                                !controller.conPassBool.value;
                          },
                          child: controller.conPassBool.value
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 20,
                                ),
                        ),
                      ),
                    ),
                  ),
                  boxHeight(20),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Utils.appButton.primaryGradientButton(
                            loading: controller.loadingButton.value,
                            child: Center(
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            onPress: () {
                              controller.onResePassword();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
