import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../Services/remote_service.dart';

class WidrawController extends GetxController {
  var isLoading = false.obs;
  TextEditingController amountController = TextEditingController();

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid", 'amount': amountController.text};
    try {
      var data = await RemoteService.post(key: "withdraw", body: body);
      var res = json.decode(data);
      Get.snackbar("Message", res["message"],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Constants.lightBlue);
      amountController.clear();
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
