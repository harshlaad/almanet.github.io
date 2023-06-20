import 'package:app/app/app_config/app_colors.dart';
import 'package:app/app/app_config/size_config.dart';
import 'package:app/utils/app_toast.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinput/pinput.dart';

import '../controllers/ride_detail_controller.dart';

class RideDetailView extends GetView<RideDetailController> {
  const RideDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy > -100) {
          controller.isSwipeUp.value = true;
        } else {
          controller.isSwipeUp.value = false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ride Detail'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: 1.fullWidth,
          height: 1.fullHeight,
          child: Obx(
            () => controller.loading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Obx(
                        () => liveLocationTracking(
                          controller.cameraPositon.value!,
                          controller.sourcePosition.value!,
                          controller.destinationPosition.value!,
                          controller.polylineCoordinates,
                        ),
                      ),
                      Obx(
                        () => AnimatedPositioned(
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 400),
                          top: !controller.isSwipeUp.value ? 0.1 : 0.7,
                          child: GestureDetector(
                            onPanEnd: (details) {
                              if (details.velocity.pixelsPerSecond.dy > -100) {
                                controller.isSwipeUp.value = true;
                              } else {
                                controller.isSwipeUp.value = false;
                              }
                            },
                            child: customBottomSheet(),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget liveLocationTracking(
    CameraPosition cameraPosition,
    LatLng sourcePosition,
    LatLng destinationPosition,
    List<LatLng> polylineCoordinates,
  ) {
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      onMapCreated: (mapC) {
        controller.mapController = mapC;
      },
      markers: {
        Marker(
          markerId: const MarkerId("source"),
          position: sourcePosition,
        ),
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationPosition,
        ),
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: const Color(0xFF7B61FF),
          width: 6,
        ),
      },
    );
  }

  Widget customBottomSheet() {
    Map<String, dynamic> data = controller.rideData.value!;
    List passengerList = data['passenger'];
    return Container(
      height: 0.9,
      width: 0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Obx(
              () => Align(
                alignment: Alignment.topCenter,
                child: (controller.isSwipeUp.value)
                    ? GestureDetector(
                        onTap: () {
                          controller.isSwipeUp.value = false;
                        },
                        child: const Icon(
                          Icons.expand_more_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.isSwipeUp.value = true;
                        },
                        child: const Icon(
                          Icons.expand_less_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            const Divider(color: Colors.grey),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['reg_no'].toString(),
                      style: TextStyle(
                        color: AppColors.blackShade1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    boxHeight(2),
                    Text(
                      "Vehicle Number",
                      style: TextStyle(
                          color: AppColors.lightBlack, fontSize: 12.sp),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
            const Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: detailCard(data['passenger'].length.toString(),
                      "No. of Passenger", 0),
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
                    child: detailCard(data['destination_time'].toString(),
                        "Destination Time", 1)),
                Container(
                  width: 0.5,
                  height: 45,
                  color: AppColors.lightBlack,
                ),
                Expanded(
                  child: detailCard(
                    data['journey_type_id'] == "1" ? "Pick" : "Drop",
                    "Ride Type",
                    2,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.lightBlack,
            ),
            boxHeight(10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Theme(
                data: Theme.of(Get.context!)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text("Passenger"),
                  children: passengerList.map((element) {
                    return passengerCard(element);
                  }).toList(),
                ),
              ),
            ),
            boxHeight(20),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Visibility(
                      visible: controller.progressIndex.value! < 3,
                      child: Utils.appButton.primaryButton(
                        loading: controller.buttonButtonLoading.value,
                        child: showButtonText(),
                        onPress: () {
                          int rideType = int.parse(
                            controller.rideData.value!['journey_type_id'],
                          );
                          if (controller.progressIndex.value == 0 &&
                                  rideType == 2 ||
                              controller.progressIndex.value == 1 &&
                                  rideType == 1) {
                            showOtpVerifyDialog();
                          } else {
                            controller.handleClick();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            boxHeight(80),
          ],
        ),
      ),
    );
  }

  Widget showButtonText() {
    int rideType = int.parse(controller.rideData.value!['journey_type_id']);
    int proIndex = controller.progressIndex.value!;
    if (rideType == 2) {
      if (proIndex == 0) {
        return const Text("Start");
      } else if (proIndex == 1) {
        return const Text("Dropped");
      } else if (proIndex == 2) {
        return const Text("End");
      } else {
        return const Text("Nothing");
      }
    } else {
      if (proIndex == 0) {
        return const Text("Start");
      } else if (proIndex == 1) {
        return const Text("Picked");
      } else if (proIndex == 2) {
        return const Text("End");
      } else {
        return const Text("Nothing");
      }
    }
  }

  Widget passengerCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(
                  data['crew_name'][0],
                  style: TextStyle(color: AppColors.black),
                ),
              ),
              boxWidth(5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['crew_name'],
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                    Text(
                      data['crew_member_type'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.lightBlack,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  call(data['Mobile_no1'].toString());
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.call_outlined),
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            children: [
              Expanded(
                child: detailCard(data['sap_no'].toString(), "SAP Code", 0),
              ),
              Container(
                width: 0.5,
                height: 45,
                color: AppColors.lightBlack,
              ),
              Expanded(
                child:
                    detailCard(data['crew_member_type'], "Passenger Type", 1),
              ),
            ],
          ),
          const Divider(color: Colors.grey),
          Text(
            data['location'],
          ),
          const Text(
            'Addresss',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
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

  void showOtpVerifyDialog() {
    final defaultPinTheme = PinTheme(
      width: (56).w,
      height: (56).h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF999999).withOpacity(0.1),
        border: Border.all(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary),
      borderRadius: BorderRadius.circular(8.r),
      shape: BoxShape.rectangle,
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Required OTP Code for Start Journey!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Passenger give you a 4 digit verification code on his/her given mobile number via SMS.",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.lightBlack,
            ),
          ),
          boxHeight(10),
          Center(
            child: Pinput(
              controller: controller.otpController,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              validator: (s) {
                return null;
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
          ),
          boxHeight(20),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => Utils.appButton.primaryButton(
                    loading: controller.submitButtonLoading.value,
                    child: const Text("Submit"),
                    onPress: () {
                      handleDialog();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    showDialog(context: Get.context!, builder: (context) => alertDialog);
  }

  Future<void> handleDialog() async {
    if (controller.otpController.text.length != 4) {
      AppToast.showSnakeBar("Please enter valid otp");
    } else {
      int rideType = int.parse(controller.rideData.value!['journey_type_id']);
      if (rideType == 2) {
        controller.dropVerifyOtp();
      } else if (rideType == 1) {
        controller.pickVerifyOtp();
      }
    }
  }
}
