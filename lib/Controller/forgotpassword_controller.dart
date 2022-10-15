import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Services/remote_service.dart';

class ForgotpasswordController extends GetxController {
  var isLoading = false.obs;
  var isOTP = false.obs;
  var isNewPass = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController newPass = TextEditingController();

  // @override
  // void onClose() {
  //   isOTP(false);
  //   isNewPass(false);
  //   email.dispose();
  //   otp.dispose();
  //   newPass.dispose();
  //   super.onClose();
  // }

  void forgotPass() async {
    isLoading(true);
    Map body = {"email": email.text};
    try {
      var value = await RemoteService.post(key: "forgot-password", body: body);
      var data = json.decode(value);
      if (data['status'] == true) {
        isLoading(false);
        isOTP(true);
      } else {
        Get.snackbar("Message", data['message'],
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

  void verifyOtp() async {
    isLoading(true);
    Map body = {
      "email": email.text,
      "otp": otp.text,
    };
    try {
      var value = await RemoteService.post(key: "forgot-password", body: body);
      var data = json.decode(value);
      if (data['status'] == true) {
        isLoading(false);
        isNewPass(true);
      } else {
        Get.snackbar("Message", data['message'],
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

  void changePass() async {
    isLoading(true);
    Map body = {
      "email": email.text,
      "otp": otp.text,
      "new-password": newPass.text,
    };
    try {
      var value = await RemoteService.post(key: "forgot-password", body: body);
      var data = json.decode(value);
      if (data['status'] == true) {
        isLoading(false);
        isOTP(false);
        isNewPass(false);
        email.clear();
        otp.clear();
        newPass.clear();
        Get.snackbar("Message", data['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Constants.lightBlue);
        Get.offAllNamed("/SignInScreen");
      } else {
        Get.snackbar("Message", data['message'],
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
