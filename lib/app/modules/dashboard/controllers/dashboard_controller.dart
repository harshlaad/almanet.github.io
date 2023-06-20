import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt rideIndex = 0.obs;
  RxBool todayRideLoading = true.obs;
  RxBool myRideLoading = true.obs;
  Rxn<List<Map<String, dynamic>>> todayRideList = Rxn();
  Rxn<List<Map<String, dynamic>>> myRideList = Rxn();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rxn<Map<String, dynamic>> content = Rxn();
  Rxn<Map<String, dynamic>> user = Rxn();

  @override
  Future<void> onInit() async {
    getUser();
    await getTodayRides();
    await getMyRides();
    await getContent();
    super.onInit();
  }

  void getUser() {
    user.value = Db.auth.getUser()!;
  }

  void onChangeIndex(int index) => rideIndex.value = index;

  Future<void> getTodayRides() async {
    todayRideLoading.value = true;
    Map<String, dynamic> user = Db.auth.getUser()!;
    Map<String, dynamic> body = {
      "cab_driver_info_id": "13",
      // user['cab_driver_info_id']
    };

    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.todayRides,
      body: body,
    );
    if (response['status'] == 200) {
      List<Map<String, dynamic>> list = [];
      List rideList = response['data']['rides'];
      for (int i = 0; i < rideList.length; i++) {
        list.add(rideList[i]);
      }
      todayRideList.value = list;
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    todayRideLoading.value = false;
  }

  Future<void> getMyRides() async {
    myRideLoading.value = true;
    Map<String, dynamic> user = Db.auth.getUser()!;
    Map<String, dynamic> body = {
      "cab_driver_info_id": "13"
      // user['cab_driver_info_id'],
    };

    Map<String, dynamic> response = await DioClient.postMethod(
      url: WebService.basic.myRides,
      body: body,
    );
    if (response['status'] == 200) {
      List<Map<String, dynamic>> list = [];
      List rideList = response['data']['rides'];
      for (int i = 0; i < rideList.length; i++) {
        list.add(rideList[i]);
      }
      myRideList.value = list;
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    myRideLoading.value = false;
  }

  Future<void> getContent() async {
    myRideLoading.value = true;
    Map<String, dynamic> response = await DioClient.getMethod(
      url: WebService.basic.getContent,
    );
    if (response['status'] == 200) {
      content.value = response['data'];
    } else {
      AppToast.showSnakeBar(response['message']);
    }
    myRideLoading.value = false;
  }
}
