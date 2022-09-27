import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/investment_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestmentController extends GetxController {
  var isLoading = false.obs;
  var investmentList = <InvestmentModel>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    try {
      isLoading(true);
      var value = await RemoteService.get(key: "investment-plans");
      var investments = investModelFromJson(value);
      if (investments.toJson().isNotEmpty) {
        investmentList.value = investments.data!;
        isLoading(false);
      } else {}
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future investNow({required String planId}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Map body = {"user_id": "${pref.getString('uId')}", "plan_id": planId};
    try {
      var value = await RemoteService.post(key: "invest-now", body: body);
      var res = json.decode(value);
      if (res["status"]) {
        Get.snackbar("Message", res["message"],
        backgroundColor: Colors.white,
            barBlur: 1, snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Message", res["message"],
            backgroundColor: Colors.white,
            barBlur: 1,
            snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
