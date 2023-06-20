import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTypeLayout.builder(
        mobile: (context) => mobileView(),
        desktop: (context) => desktopView(),
      ),
    );
  }

  Widget mobileView() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          loginForm(),
        ],
      ),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: Assets.images.bubble.image(),
        ),
        Padding(
          padding: EdgeInsets.all(2.r),
          child: Row(
            children: [
              Expanded(
                child: Assets.images.loginBg.image(fit: BoxFit.fill),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: loginForm())),
            ],
          ),
        ),
      ],
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.iconsc.logo.image(width: 20.w),
        boxHeight(2),
        Container(
          padding: const EdgeInsets.all(21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Sell, market and service with the ",
                      style: TextStyle(
                        color: AppColors.darkblue,
                        fontSize: 2.5.sp,
                      ),
                    ),
                    TextSpan(
                      text: "world's #1CRM",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 2.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
              boxHeight(1),
              Text(
                "By using the latest digital technology, Mobile Medical Diagnostics provides a community based and flexible radiology services solution, resulting in improved access to diagnostic services for healthcare facilities nationwide.",
                style: TextStyle(fontSize: 1.sp),
              ),
              boxHeight(2),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: textFieldHeading("Username/email"),
              ),
              TextFormField(
                decoration: Utils.appDecorations.inputDecorationPrefix(
                    "Enter E-mail",
                    Icon(
                      Icons.email_outlined,
                      color: AppColors.grey,
                    )),
              ),
              boxHeight(1),
              Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: textFieldHeading("Password")),
              Obx(
                () => TextFormField(
                  obscureText: !controller.isShowPass.value,
                  decoration: Utils.appDecorations.inputDecorationPrefixSuffix(
                    "Enter Password",
                    Icon(
                      Icons.key_outlined,
                      color: AppColors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.isShowPass.value =
                            !controller.isShowPass.value;
                      },
                      child: Obx(
                        () => controller.isShowPass.value
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.grey,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: AppColors.grey,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              boxHeight(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: AppColors.grey, // Your color
                        ),
                        child: Obx(
                          () => Checkbox(
                              value: controller.check.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.check.value = value;
                                }
                              }),
                        ),
                      ),
                      boxWidth(1),
                      Text(
                        "Remember me",
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(color: AppColors.lightBlack),
                    ),
                  ),
                ],
              ),
              boxHeight(2),
              Row(
                children: [
                  Expanded(
                    child: Utils.appButton.primaryButton(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(fontSize: 1.2.h),
                      ),
                      onPress: () {},
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // boxHeight(20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Don\'t have an account ?',
        //       style: TextStyle(color: AppColors.lightBlack),
        //     ),
        //     TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Sign Up",
        //         style: TextStyle(color: AppColors.primary),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
