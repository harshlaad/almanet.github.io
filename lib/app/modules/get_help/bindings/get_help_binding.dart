import 'package:get/get.dart';

import '../controllers/get_help_controller.dart';

class GetHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetHelpController>(
      () => GetHelpController(),
    );
  }
}
