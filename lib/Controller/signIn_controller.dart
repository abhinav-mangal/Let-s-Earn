import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lets_earn/Model/signin_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;
  var isVisible = true.obs;

  void signIn() async {
    final prefs = await SharedPreferences.getInstance();

    Map body = {"phone": phoneNumber.text, "password": password.text};
    try {
      isLoading(true);
      var value = await RemoteService.post(key: "login", body: body);
      var data = signInModelFromJson(value);
      if (data.status == true) {
        await prefs.setString("userContact", phoneNumber.text);
        await prefs.setString("uId", data.userId!);
        Get.offAllNamed("/TabBarController");
      } else {
        Get.snackbar("Message", data.message,
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
