import 'package:app/services/api_services/dio_client.dart';
import 'package:app/services/api_services/web_service.dart';
import 'package:app/services/local_db/local_db.dart';
import 'package:app/utils/app_toast.dart';
import 'package:app/utils/resuable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  TextEditingController message = TextEditingController();
  RxBool buttonLoading = false.obs;

  Future<void> onSubmit() async {
    hideKeyboard();
    if (message.text == "") {
      AppToast.showSnakeBar("Please enter message");
    } else {
      buttonLoading.value = true;
      Map<String, dynamic> user = Db.auth.getUser()!;
      Map<String, dynamic> body = {
        "user_id": user['user_id'],
        "type": "Passenger",
        "message": message.text,
      };

      Map<String, dynamic> response = await DioClient.postMethod(
        url: WebService.basic.contactUs,
        body: body,
      );
      if (response['status'] == 200) {
        AppToast.showSnakeBar("Form Submitted",
            duration: const Duration(seconds: 2));
        message.clear();
      } else {
        AppToast.showSnakeBar(response['message']);
      }
      buttonLoading.value = false;
    }
  }
}
