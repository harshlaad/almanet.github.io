import 'package:app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:get/get.dart';

class DashboardDrawerController extends GetxController {
  Rxn<Map<String, dynamic>> user = Rxn();

  List<Map<String, dynamic>> itemList = [
    {"name": "Profile", "image": Assets.iconsc.profile.svg(), "id": 10},
    {"name": "Today Rides", "image": Assets.iconsc.todayRides.svg(), "id": 2},
    {"name": "My Rides", "image": Assets.iconsc.myRides.svg(), "id": 3},
    {"name": "About Us", "image": Assets.iconsc.aboutUs.svg(), "id": 4},
    {
      "name": "Terms & Conditions",
      "image": Assets.iconsc.termConditions.svg(),
      "id": 5
    },
    {
      "name": "Get Help & Supports",
      "image": Assets.iconsc.getHelp.svg(),
      "id": 6
    },
    {
      "name": "Privacy & Policy",
      "image": Assets.iconsc.contactUs.svg(),
      "id": 9
    },
    {"name": "Contact Us", "image": Assets.iconsc.contactUs.svg(), "id": 7},
    {"name": "Log Out", "image": Assets.iconsc.signOut.svg(), "id": 8},
  ];
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() {
    user.value = Db.auth.getUser()!;
  }

  void handleClick(int id, Function() onLogout) {
    Get.back();
    if (id == 1) {
      Get.toNamed(Routes.EDIT_PROFILE);
    } else if (id == 2) {
      DashboardController dashboardController = Get.find();
      dashboardController.rideIndex.value = 0;
    } else if (id == 3) {
      DashboardController dashboardController = Get.find();
      dashboardController.rideIndex.value = 1;
    } else if (id == 4) {
      Get.toNamed(Routes.ABOUT_US);
    } else if (id == 5) {
      Get.toNamed(Routes.TERMS_CONDITIONS);
    } else if (id == 6) {
      Get.toNamed(Routes.GET_HELP);
    } else if (id == 7) {
      Get.toNamed(Routes.CONTACT_US);
    } else if (id == 8) {
      onLogout();
    } else if (id == 9) {
      Get.toNamed(Routes.PRIVACY_POLICY);
    } else if (id == 10) {
      Get.toNamed(Routes.PROFILE);
    } else {
      AppToast.showSnakeBar("Comming Soon");
    }
  }
}
