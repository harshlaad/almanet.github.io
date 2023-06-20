import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  final OutlineInputBorder _borderWithPrimaryColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(0.5.r),
    borderSide: BorderSide(
      color: AppColors.primary,
      width: 1.5,
    ),
  );

  final OutlineInputBorder _borderWithGreyColor = OutlineInputBorder(
    borderRadius: BorderRadius.circular(0.5.r),
    borderSide: BorderSide(
      color: Colors.grey.shade300,
      width: 1.5,
    ),
  );

  BoxDecoration boxDecoration1() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0.5.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    );
  }

  InputDecoration inputDecorationPrefix(String hint, Widget suffixIcon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.grey),
      border: _borderWithGreyColor,
      focusedBorder: _borderWithPrimaryColor,
      disabledBorder: _borderWithGreyColor,
      enabledBorder: _borderWithGreyColor,
      fillColor: Colors.white,
      filled: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: suffixIcon,
      ),
    );
  }

  InputDecoration inputDecorationPrefixSuffix(
      String hint, Widget prefix, Widget suffix) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.grey),
      border: _borderWithGreyColor,
      focusedBorder: _borderWithPrimaryColor,
      disabledBorder: _borderWithGreyColor,
      enabledBorder: _borderWithGreyColor,
      fillColor: Colors.white,
      filled: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: prefix,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: suffix,
      ),
    );
  }

  InputDecoration inputDecoration1(String hint, Widget suffixIcon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.lightBlack),
      border: _borderWithGreyColor,
      focusedBorder: _borderWithPrimaryColor,
      disabledBorder: _borderWithGreyColor,
      enabledBorder: _borderWithGreyColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
      fillColor: const Color(0xFFF9F9F9),
      filled: true,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 25.h,
        maxWidth: 25.w,
        minHeight: 25.h,
        minWidth: 25.w,
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: suffixIcon,
      ),
    );
  }

  InputDecoration inputDecoration2(String hint) {
    return InputDecoration(
      hintText: hint,
      border: _borderWithGreyColor,
      focusedBorder: _borderWithPrimaryColor,
      disabledBorder: _borderWithGreyColor,
      enabledBorder: _borderWithGreyColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
      fillColor: const Color(0xFFF9F9F9),
      filled: true,
    );
  }

  ButtonStyleData dropDownDecoration1() {
    return ButtonStyleData(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}
