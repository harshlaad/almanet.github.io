import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton {
  Widget backButton(
      {Color? buttonColor,
      Color? iconColor,
      Function()? onPress,
      Widget? icon}) {
    return GestureDetector(
      onTap: onPress ??
          () {
            Get.back();
          },
      child: Container(
        height: 35.h,
        width: 40.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: icon ??
            Assets.iconsc.back.svg(
              color: iconColor ?? AppColors.primary,
            ),
      ),
    );
  }

  Widget primaryGradientButton(
      {required Widget child,
      required Function() onPress,
      bool loading = false}) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        onPressed: loading ? () {} : onPress,
        child: loading
            ? const Center(
                child: Padding(
                padding: EdgeInsets.all(2),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ))
            : child,
      ),
    );
  }

  Widget primaryButton({
    required Widget child,
    required Function() onPress,
    bool loading = false,
    double? borderRadius,
  }) {
    return SizedBox(
      height: 4.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
          ),
        ),
        onPressed: loading ? () {} : onPress,
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : child,
      ),
    );
  }
}
