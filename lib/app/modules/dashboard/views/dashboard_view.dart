import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/app/modules/dashboard_drawer/views/dashboard_drawer_view.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        endDrawer: const DashboardDrawerView(),
        appBar: Utils.appBar.defaultAppBar(
          () {
            controller.scaffoldKey.currentState!.openEndDrawer();
          },
        ),
        body: ListView(
          primary: true,
          children: [
            Obx(() => profile()),
            boxHeight(10),
            Obx(
              () => rides(),
            )
          ],
        ),
      ),
    );
  }

  Widget rides() {
    bool today = controller.rideIndex.value == 0;
    bool my = controller.rideIndex.value == 1;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                controller.onChangeIndex(0);
              },
              child: Container(
                height: 45.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: today ? AppColors.primary : const Color(0xFFFAFAF9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    boxWidth(10),
                    Text(
                      "Today's Rides",
                      style: TextStyle(
                        color: today ? Colors.black : const Color(0xFFB9B9B9),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controller.todayRideList.value == null
                          ? "0"
                          : controller.todayRideList.value!.length.toString(),
                      style: TextStyle(
                        color: today ? Colors.black : const Color(0xFFB9B9B9),
                      ),
                    ),
                    boxWidth(10),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.onChangeIndex(1);
              },
              child: Container(
                height: 45.h,
                width: 150.w,
                decoration: BoxDecoration(
                  color: my ? AppColors.primary : const Color(0xFFFAFAF9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    boxWidth(10),
                    Text(
                      "My Rides",
                      style: TextStyle(
                        color: my ? Colors.black : const Color(0xFFB9B9B9),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      controller.myRideList.value == null
                          ? "0"
                          : controller.myRideList.value!.length.toString(),
                      style: TextStyle(
                        color: my ? Colors.black : const Color(0xFFB9B9B9),
                      ),
                    ),
                    boxWidth(10),
                  ],
                ),
              ),
            )
          ],
        ),
        boxHeight(10),
        Obx(
          () => Visibility(
            visible: controller.rideIndex.value == 0,
            replacement: myRides(),
            child: todayRides(),
          ),
        ),
      ],
    );
  }

  Widget todayRides() {
    return Obx(
      () => Utils.appWidgets.emptyData(
        controller.todayRideLoading.value,
        controller.todayRideList.value,
        ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 21.w,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.todayRideList.value == null
              ? 0
              : controller.todayRideList.value!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = controller.todayRideList.value![index];
            // return Text(data.toString());
            return todayRideCard(data);
          },
        ),
      ),
    );
  }

  Widget myRides() {
    return Obx(
      () => Utils.appWidgets.emptyData(
        controller.myRideLoading.value,
        controller.myRideList.value,
        ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 21.w,
          ),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.myRideList.value == null
              ? 0
              : controller.myRideList.value!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = controller.myRideList.value![index];
            // return Text(data.toString());
            return todayRideCard(data);
          },
        ),
      ),
    );
  }

  Widget todayRideCard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: Utils.appDecorations.boxDecoration1(),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0;
                  i <
                      (data['passenger'].length <= 2
                          ? data['passenger'].length
                          : 3);
                  i++)
                Align(
                  widthFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.black)),
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 20,
                      child: Text(
                        i < 2
                            ? data['passenger'][i]['crew_name'][0].toString()
                            : "+${data['passenger'].length - 1}",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              boxWidth(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 0;
                            i <
                                (data['passenger'].length <= 2
                                    ? data['passenger'].length
                                    : 3);
                            i++)
                          Text(
                            "${data['passenger'][i]['crew_name'].toString().split(" ")[0]}${(i == 0 && data['passenger'].length == 2) ? " & " : ""}",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        for (int i = 0;
                            i <
                                (data['passenger'].length <= 2
                                    ? data['passenger'].length
                                    : 3);
                            i++)
                          Text(
                            "${data['passenger'][i]['crew_member_type'].toString().split(" ")[1]}${(i == 0 && data['passenger'].length == 2) ? " / " : ""}",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          boxHeight(10),
          Row(
            children: [
              Expanded(
                child: detailCard(
                    data['passenger'].length.toString(), "No. of Passenger", 0),
              ),
              Container(
                width: 0.5,
                height: 45,
                color: AppColors.lightBlack,
              ),
              Expanded(
                  child:
                      detailCard(data['reg_no'].toString(), "Vehicle No", 1)),
              Container(
                width: 0.5,
                height: 45,
                color: AppColors.lightBlack,
              ),
              Expanded(
                  child: detailCard(data['journey_date'], "Journey Date", 2)),
            ],
          ),
          Divider(
            color: AppColors.lightBlack,
          ),
          Row(
            children: [
              Expanded(
                  child: detailCard(
                      data['moving_time'].toString(), "Moving Time", 0)),
              Container(
                width: 0.5,
                height: 45,
                color: AppColors.lightBlack,
              ),
              Expanded(
                child: detailCard(
                    data['destination_time'].toString(), "Destination Time", 1),
              ),
              Container(
                width: 0.5,
                height: 45,
                color: AppColors.lightBlack,
              ),
              Expanded(
                child: detailCard(
                  data['yard_time'],
                  "Yard Time",
                  2,
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.lightBlack,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              detailCard(
                data['journey_type_id'] == "1" ? "Pick" : "Drop",
                "Ride Type",
                0,
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                onPressed: () {
                  Db.basic.setRoasterId(
                      // "6",
                      data['roster_final_id']);
                  Get.toNamed(Routes.RIDE_DETAIL);
                },
                child: const Text(
                  "View Passenger Details",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailCard(String title, String detail, int position) {
    return Column(
      crossAxisAlignment: position == 0
          ? CrossAxisAlignment.start
          : position == 1
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
        boxHeight(2),
        Text(
          detail,
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget profile() {
    Map<String, dynamic> user = controller.user.value!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Row(
            children: [
              profileImage(user['profile_image'] ?? '', () => null),
              boxWidth(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['first_name'] ?? "" " " + user['last_name'] ?? "",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    boxHeight(4),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.blackShade1,
                          child: const Icon(
                            Icons.phone_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        boxWidth(5),
                        Text(user['phone_no'].toString()),
                      ],
                    ),
                    boxHeight(4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.blackShade1,
                          child: const Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        boxWidth(5),
                        Expanded(
                          child: Text(
                            user['email'] ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
