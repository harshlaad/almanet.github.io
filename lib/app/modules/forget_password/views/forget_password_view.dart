import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
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
                    "Forget Password ?",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Please enter registered mobile number",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  boxHeight(20),
                  TextFormField(
                    controller: controller.phoneCon,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: Utils.appDecorations
                        .inputDecoration1(
                          "Mobile number",
                          Assets.iconsc.phone.svg(),
                        )
                        .copyWith(counterText: ""),
                  ),
                  boxHeight(20),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Utils.appButton.primaryGradientButton(
                            loading: controller.buttonLoading.value,
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.sp),
                              ),
                            ),
                            onPress: () {
                              controller.onContinue();
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
