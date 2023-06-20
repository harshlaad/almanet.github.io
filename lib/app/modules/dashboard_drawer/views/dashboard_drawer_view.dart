import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_drawer_controller.dart';

class DashboardDrawerView extends GetView<DashboardDrawerController> {
  const DashboardDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: 1.fullWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          margin: EdgeInsets.all(21.r),
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Obx(
                    () => profile(),
                  ),
                  boxHeight(5),
                  ListView.builder(
                    padding: EdgeInsets.only(left: 10.w),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.itemList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item = controller.itemList[index];
                      return GestureDetector(
                        onTap: () {
                          controller.handleClick(
                            item['id'],
                            () {
                              showLogoutDialog();
                            },
                          );
                        },
                        child: Column(
                          children: [
                            boxHeight(8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: item['image'],
                                ),
                                boxWidth(10),
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackShade1,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            boxHeight(8),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                boxWidth(10),
                                const Expanded(
                                  flex: 9,
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  boxHeight(5),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                    ),
                    child: const Text(
                      'Copyright@Stargateindia.com All rights reserves.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profile() {
    Map<String, dynamic> user = controller.user.value!;
    return Column(
      children: [
        profileImage(user['profile_image'] ?? '', () => null),
        boxHeight(20),
        Text(
          user['first_name'] ?? "" " " + user['last_name'] ?? "",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
            Get.toNamed(Routes.EDIT_PROFILE);
          },
          child: const Text("Edit Profile"),
        )
      ],
    );
  }

  void showLogoutDialog() {
    Dialog dialog = Dialog(
      child: Padding(
        padding: EdgeInsets.all(21.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Do you want to logout ? ",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            boxHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN);
                      Db.clear();
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                boxWidth(10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey)),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: Get.context!, builder: (context) => dialog);
  }
}
