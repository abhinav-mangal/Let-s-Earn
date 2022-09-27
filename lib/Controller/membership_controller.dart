import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/membership_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipController extends GetxController {
  var isLoading = false.obs;
  var message = "".obs;
  var membershipList = <MembershipData>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    try {
      isLoading(true);
      final SharedPreferences pref = await SharedPreferences.getInstance();
      Map body = {"user_id": "${pref.getString('uId')}"};
      var value = await RemoteService.post(key: "get-membership", body: body);
      var membership = membershipFromJson(value);
      if (membership.toJson().isNotEmpty) {
        membershipList.value = membership.data;
        isLoading(false);
      } else {}
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future buyMembership({required String id}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Map body = {"user_id": "${pref.getString('uId')}", "vip_no": id};
    try {
      isLoading(true);
      var value = await RemoteService.post(key: "buy-membership", body: body);
      debugPrint(value);
      var data = json.decode(value);
      message.value = data["message"];
      if (data["redirect"]) Get.toNamed("/PurchaseScreen");
      isLoading(false);
    } catch (e) {
      Get.snackbar("Message", "Something went wrong!",
          barBlur: 0, snackPosition: SnackPosition.TOP);
    }
  }
}
