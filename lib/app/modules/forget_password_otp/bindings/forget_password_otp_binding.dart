import 'package:get/get.dart';

import '../controllers/forget_password_otp_controller.dart';

class ForgetPasswordOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordOtpController>(
      () => ForgetPasswordOtpController(),
    );
  }
}
