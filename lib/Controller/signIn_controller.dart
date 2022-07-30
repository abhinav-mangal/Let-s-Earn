// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lets_earn/Model/signin_model.dart';
import 'package:lets_earn/Services/remote_service.dart';

class SignInController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;

  void signIn() async {
    try {
      isLoading(true);
      SignInModel value =
          await RemoteService.signIn(phoneNumber.text, password.text);
      Get.toNamed("/SignInScreen");
      if (value.status) {
        Get.toNamed("/SignInScreen");
      } else {
        Get.snackbar("Message", value.msg);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
