import 'package:app/app/app_config/size_config.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Text(controller.name.value),
          Center(
            child: Assets.iconsc.logo.image(
              height: 120.h,
              width: 120.w,
            ),
          ),
        ],
      ),
    );
  }
}
