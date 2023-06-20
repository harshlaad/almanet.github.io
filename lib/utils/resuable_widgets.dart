import 'dart:developer';
import 'dart:io';

import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

SizedBox boxWidth(double width) {
  return SizedBox(width: width.w);
}

SizedBox boxHeight(double height) {
  return SizedBox(height: height.h);
}

YearPicker yearPicker(DateTime intialDate, Function(DateTime) onChange) {
  return YearPicker(
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    selectedDate: intialDate,
    onChanged: onChange,
  );
}

Future<DateTime?> dateTimePicker(DateTime intialDate) async {
  final DateTime? picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
      context: Get.context!,
      initialDate: intialDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: AppColors.primary)
                .copyWith(secondary: AppColors.primary),
          ),
          child: child!,
        );
      });
  return picked;
}

Widget profileImage(String image, Function() onPress,
    {Widget? editWidget, XFile? updateImage}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      height: 110.h,
      width: 110.w,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          updateImage == null
              ? Center(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 110.h,
                    width: 110.w,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Assets.images.profile.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    width: 110.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(
                          File.fromUri(
                            Uri.parse(updateImage.path),
                          ),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onPress,
              child: editWidget ?? const SizedBox(),
            ),
          ),
        ],
      ),
    ),
  );
}

extension StringExtension on String {
  String firstCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future<void> call(String contactNumber) async {
  final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
  try {
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    }
  } catch (error) {
    throw ("Cannot dial");
  }
}

void viewPhoto(Map<String, dynamic> data) {
  List<String> photoList = [
    data['front_side_photo'],
    data['back_side_photo'],
    data['left_side_photo'],
    data['right_side_photo'],
    data['milo_miter_photo'],
    data['rc_photo'],
    // data['milo_milter_photo'],
  ];
  CarouselController carouselController = CarouselController();
  log(photoList.toString());
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 21.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      boxHeight(10),
                      CarouselSlider(
                        carouselController: carouselController,
                        items: photoList.map(
                          (e) {
                            return CachedNetworkImage(
                                imageUrl: WebService.baseUrl + e);
                          },
                        ).toList(),
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0,
                          initialPage: 2,
                          enableInfiniteScroll: false,
                        ),
                      ),
                      boxHeight(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Utils.appText.subHeading("Remark"),
                            boxHeight(5),
                            Text(data['remark'])
                          ],
                        ),
                      ),
                      boxHeight(10),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 21.w,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      carouselController.nextPage();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 21.w,
                child: IconButton(
                  onPressed: () {
                    carouselController.previousPage();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 21.h,
                right: 21.w,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showBox(String title, Widget child) {
  AlertDialog alertDialog = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(""),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ),
    content: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
              boxHeight(10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(context: Get.context!, builder: (context) => alertDialog);
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void uploadImage(String title, Function(XFile) onImageTaken) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    context: Get.context!,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 21.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined),
            title: const Text("Camera"),
            onTap: () async {
              XFile? xFile = await Utils.appImagePicker.pickImageCamera();
              Get.back();
              if (xFile != null) {
                onImageTaken(xFile);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_outlined),
            title: const Text("Gallery"),
            onTap: () async {
              XFile? xFile = await Utils.appImagePicker.pickImageGallery();
              Get.back();
              if (xFile != null) {
                onImageTaken(xFile);
              }
            },
          )
        ],
      ),
    ),
  );
}

Widget textFieldHeading(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.lightBlack, fontSize: 1.h),
  );
}
