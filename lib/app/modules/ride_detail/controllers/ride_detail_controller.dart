import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app/app/app_config/size_config.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/firebase/map_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class RideDetailController extends GetxController {
  RxBool loading = true.obs;
  RxBool buttonButtonLoading = false.obs;
  RxBool submitButtonLoading = false.obs;
  Rxn<Map<String, dynamic>> rideData = Rxn();
  RxBool isSwipeUp = true.obs;
  Rxn<int> progressIndex = Rxn();
  TextEditingController otpController = TextEditingController();
  RxBool confirmationButton = false.obs;

  Rxn<CameraPosition> cameraPositon = Rxn();
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  Rxn<LatLng> sourcePosition = Rxn(const LatLng(22.746305, 75.892879));
  Rxn<LatLng> destinationPosition = Rxn();
  late GoogleMapController mapController;
  StreamSubscription<LocationData>? trackingStream;
  TextEditingController operatorRemarkCon = TextEditingController();
  Rxn<XFile> prescriptionImage = Rxn();

  @override
  Future<void> onInit() async {
    loading.value = true;
    await getRideDetail();
    progressIndex.value = int.parse(rideData.value!['roster_final_status']);
    await getData();
    loading.value = false;

    super.onInit();
  }

  Future<void> getRideDetail() async {
    String roasterId = Db.basic.getRoasterId();
    Map<String, dynamic> body = {"roster_final_id": roasterId};
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.rideDetail,
      body: body,
    );
    log("get ride detail response $response");
    if (response['status'] == 200) {
      rideData.value = response['data']['ride'];
    } else {
      AppToast.showSnakeBar(response['message']);
    }
  }

  Future<void> pickStartRide() async {
    buttonButtonLoading.value = true;
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.pickStart,
      body: {
        "roster_final_id": rideData.value!["roster_final_id"],
        "time": DateFormat('hh:mm:ss').format(DateTime.now()),
      },
    );
    if (response['status'] == 200) {
      progressIndex.value = int.parse(response['data']['roster_final_status']);
      AppToast.showSnakeBar('Pick Start');
    } else {
      AppToast.showSnakeBar(response['message']);
    }

    buttonButtonLoading.value = false;
  }

  Future<void> pickVerifyOtp() async {
    submitButtonLoading.value = true;
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.pickVerifyOtp,
      body: {
        "roster_final_id": rideData.value!["roster_final_id"],
        "otp": otpController.text,
        "time": DateFormat('hh:mm:ss').format(DateTime.now()),
      },
    );
    if (response['status'] == 200) {
      progressIndex.value = int.parse(response['data']['roster_final_status']);
      AppToast.showSnakeBar('Pick Verify Otp');

      Get.back();
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    submitButtonLoading.value = false;
  }

  Future<void> dropVerifyOtp() async {
    submitButtonLoading.value = true;
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.dropStart,
      body: {
        "roster_final_id": rideData.value!["roster_final_id"],
        "otp": otpController.text,
        "time": DateFormat('hh:mm:ss').format(DateTime.now()),
      },
    );
    if (response['status'] == 200) {
      progressIndex.value = int.parse(response['data']['roster_final_status']);
      AppToast.showSnakeBar('Drop Verify Otp');

      Get.back();
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    submitButtonLoading.value = false;
  }

  Future<void> droppedRide() async {
    buttonButtonLoading.value = true;
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.dropDropped,
      body: {
        "roster_final_id": rideData.value!["roster_final_id"],
        "time": DateFormat('hh:mm:ss').format(DateTime.now()),
      },
    );
    if (response['status'] == 200) {
      progressIndex.value = int.parse(response['data']['roster_final_status']);
      AppToast.showSnakeBar('Dropped Verify Otp');
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    buttonButtonLoading.value = false;
  }

  Future<void> endRide() async {
    buttonButtonLoading.value = true;
    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.endRide,
      body: {
        "roster_final_id": rideData.value!["roster_final_id"],
        "time": DateFormat("hh:mm:ss").format(DateTime.now()),
      },
    );
    log(response.toString());
    if (response['status'] == 200) {
      progressIndex.value = int.parse(response['data']['roster_final_status']);
      Get.offAllNamed(Routes.DASHBOARD);
      AppToast.showSnakeBar('End');
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    buttonButtonLoading.value = false;
  }

  Future<void> handleClick() async {
    int rideType = int.parse(rideData.value!['journey_type_id']);
    int proIndex = progressIndex.value!;
    log(rideType.toString());
    log(proIndex.toString());
    showConfirmationDialog(proIndex, rideType);
  }

  void changeDestinationLocation(LatLng latLng) {
    destinationPosition.value = latLng;
  }

  Future<void> getData() async {
    Position position = await _determinePosition();
    cameraPositon.value = CameraPosition(
      zoom: 19,
      target: LatLng(position.latitude, position.longitude),
    );
    bool isPickUp = rideData.value!['journey_type_id'] == "1";
    if (isPickUp) {
      List list = rideData.value!['passenger'];
      log(list.toString());
      Map<String, dynamic> passengerHomeAddress =
          jsonDecode(list[0]['home_address']);
      changeDestinationLocation(
        LatLng(
          passengerHomeAddress['lat'],
          passengerHomeAddress['long'],
        ),
      );
    } else {
      changeDestinationLocation(
        const LatLng(
          19.0,
          19.0023,
        ),
      );
    }
    log("log 1");
    Location location = Location();
    log("log 2");
    trackingStream = location.onLocationChanged.listen(
      (loc) async {
        MapService.addTracking(
          rideData.value!['roster_final_id'],
          {
            "tracking_status": false,
            "latitude": loc.latitude.toString(),
            "longitude": loc.longitude.toString(),
          },
        );
        sourcePosition.value = LatLng(loc.latitude!, loc.longitude!);
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 35,
              target: LatLng(
                loc.latitude!,
                loc.longitude!,
              ),
            ),
          ),
        );

        await getPolyPoints();
      },
    );
  }

  Future<void> getPolyPoints() async {
    List<LatLng> polyList = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB8mgEHYikK8livtD6Imnyy3zMMoHXWWXw",
      PointLatLng(
          sourcePosition.value!.latitude, sourcePosition.value!.longitude),
      PointLatLng(destinationPosition.value!.latitude,
          destinationPosition.value!.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyList.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    } else {}
    polylineCoordinates.value = polyList;
    polylineCoordinates.refresh();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void showConfirmationDialog(int proIndex, int rideType) {
    AlertDialog alertDialog = AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text((rideType == 2)
                ? (proIndex == 1)
                    ? "Are you sure to drop ride ?"
                    : "Are you sure to end ride ?"
                : (proIndex == 0)
                    ? "Are you sure to start ride ?"
                    : "Are you sure to end ride ?"),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          boxHeight(20),
          SizedBox(
            height: 38,
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Utils.appButton.primaryButton(
                      borderRadius: 10.r,
                      loading: confirmationButton.value,
                      child: const Text("Yes"),
                      onPress: () {
                        confirmationButton.value = true;
                        Get.back();
                        if (rideType == 2) {
                          if (proIndex == 1) {
                            droppedRide();
                          } else {
                            endRide();
                          }
                        } else {
                          if (proIndex == 0) {
                            pickStartRide();
                          } else {
                            endRide();
                          }
                        }
                        confirmationButton.value = false;
                      },
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
                      "No",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    showDialog(context: Get.context!, builder: (context) => alertDialog);
  }
}
