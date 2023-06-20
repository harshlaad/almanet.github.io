import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_help_controller.dart';

class GetHelpView extends GetView<GetHelpController> {
  const GetHelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Get Help & Support"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Assets.iconsc.logo.image(height: 80, width: 80)),
              boxHeight(20),
              Center(
                child: Text(
                  'Get Help & Support : ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              boxHeight(20),
              Row(
                children: [
                  const Icon(Icons.call_outlined),
                  boxWidth(10),
                  Expanded(
                    child: Text(
                      controller.dashboardController.content
                          .value!['help_support_number']
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.mail_outline),
                  boxWidth(10),
                  Expanded(
                    child: Text(
                      controller.dashboardController.content
                          .value!['help_support_email']
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
