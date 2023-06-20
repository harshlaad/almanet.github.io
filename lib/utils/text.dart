import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:flutter/widgets.dart';

class AppText {
  Text heading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
    );
  }

  Text subHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
    );
  }
}
