import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Contact Us"),
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
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.iconsc.logo.image(
                height: 50.h,
                width: 50.w,
              ),
              boxHeight(10),
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              boxHeight(20),
              TextFormField(
                maxLines: null,
                minLines: 5,
                controller: controller.message,
                decoration: Utils.appDecorations
                    .inputDecoration2("Enter message")
                    .copyWith(
                      contentPadding: const EdgeInsets.all(10),
                    ),
              ),
              boxHeight(20),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 5,
                    child: Obx(
                      () => Utils.appButton.primaryButton(
                        loading: controller.buttonLoading.value,
                        child: const Text("Submit"),
                        onPress: () {
                          controller.onSubmit();
                        },
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
