import 'package:app/app/modules/dashboard_drawer/controllers/dashboard_drawer_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<DashboardDrawerController>(
      () => DashboardDrawerController(),
    );
  }
}
