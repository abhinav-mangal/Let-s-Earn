import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../Model/signup_model.dart';

class SignUpController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController email = TextEditingController();
  var isLoading = false.obs;

  void signUp() async {
    final prefs = await SharedPreferences.getInstance();
    Map body = {
      "name": name.text,
      "email": email.text,
      "phone": phoneNumber.text,
      "password": password.text,
      "referral_code": referralCode.text,
    };
    try {
      isLoading(true);
      var value = await RemoteService.post(key: "register", body: body);
      var data = signUpModelFromJson(value);
      if (data.status == true) {
        await prefs.setString("uId", data.id!.toString());
        Get.offAllNamed("/TabBarController");
      } else {
        Get.snackbar("Message", data.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Constants.lightBlue);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
