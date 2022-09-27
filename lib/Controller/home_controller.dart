import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/achivements_model.dart';
import 'package:lets_earn/Model/banner_model.dart';
import 'package:lets_earn/Model/invite_friends_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var achivements = <AchievementsList>[].obs;
  var banner = <String>[].obs;
  var refferal = <String>[].obs;
  var refferalMessage = "".obs;
  var totalEarnings = "".obs;

  @override
  void onInit() async {
    isLoading(true);
    await getBanner();
    await getAchivements();
    await getRefferal();
    await getEarnings();
    isLoading(false);
    super.onInit();
  }

  Future getBanner() async {
    try {
      var bannerCall = await RemoteService.get(key: "banner");
      var bannerList = bannerModelFromJson(bannerCall);
      if (bannerList.status) {
        banner.value = bannerList.banner!;
      } else {
        Get.snackbar("Message", "Something went wrong!",
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future getRefferal() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data =
          await RemoteService.post(key: "invite-your-friends", body: body);
      var refferalData = inviteYourFriendsFromJson(data);
      if (refferalData.status == true) {
        refferal.value = refferalData.data;
        refferalMessage.value = refferalData.message.toString();
      } else {
        Get.snackbar("Message", "Something went wrong!",
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future getAchivements() async {
    try {
      var achivementsCall = await RemoteService.get(key: "achievements");
      var achivementsList = achievementsModelFromJson(achivementsCall);
      if (achivementsList.status == true) {
        achivements.value = achivementsList.data!;
      } else {
        Get.snackbar("Message", "Something went wrong!",
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future getEarnings() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data = await RemoteService.post(key: "user-balance", body: body);
      var res = json.decode(data);
      if (res["status"] == true) {
        totalEarnings.value = res['balance'];
        // Get.snackbar("Message", res['message'],
        //     barBlur: 0, snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Message", "Something went wrong!",
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
