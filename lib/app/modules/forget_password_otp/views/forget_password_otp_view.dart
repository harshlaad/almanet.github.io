import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/forget_password_otp_controller.dart';

class ForgetPasswordOtpView extends GetView<ForgetPasswordOtpController> {
  const ForgetPasswordOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: (56).w,
      height: (56).h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF999999).withOpacity(0.1),
        border: Border.all(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(8.r),
      shape: BoxShape.rectangle,
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
            iconColor: Colors.black,
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
                    "Enter OTP Code",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "We have sent you a 4 digit verification code on the given mobile number.",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  boxHeight(20),
                  Center(
                    child: Pinput(
                      controller: controller.otpCon,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        return null;
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                  boxHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn’t get a code? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                      boxWidth(5),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Click To Resend",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
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
                                "Verify",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                            onPress: () {
                              controller.onVerify();
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
