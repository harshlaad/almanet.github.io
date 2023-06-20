import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppAppBar {
  AppBar defaultAppBar(Function() onPress) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: const [SizedBox()],
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          top: 5.h,
          right: 10.w,
          left: 10.w,
        ),
        child: Row(
          children: [
            Assets.iconsc.logo.image(
              height: 40.h,
              width: 40.w,
            ),
            const Spacer(),
            GestureDetector(
              onTap: onPress,
              child: Utils.appButton.backButton(
                buttonColor: AppColors.primary,
                iconColor: Colors.white,
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPress: onPress,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
