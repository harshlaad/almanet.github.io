import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("About Us"),
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
        body: Padding(
          padding: EdgeInsets.all(21.r),
          child: ListView(
            children: [
              Text(
                'About us : ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              boxHeight(20),
              Text(
                controller.dashboardController.content.value!['about_us']
                    .toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
