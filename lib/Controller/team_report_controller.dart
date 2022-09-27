import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/record_model.dart';
import 'package:lets_earn/Model/team_report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/remote_service.dart';

class TeamReportController extends GetxController {
  // var records = <RecordList>[].obs;
  TeamReportData? teamReport;
  var isLoading = false.obs;
  List<Level1> list = <Level1>[].obs;

  @override
  void onInit() async {
    await getTeamReport();
    isLoading(true);
    super.onInit();
  }

  Future getTeamReport() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data = await RemoteService.post(key: "referral-user", body: body);
      var res = teamReportModelFromJson(data);
      teamReport = res.data;
      update();
      // print(teamReportData);
      // var teamReportData = teamReportModelFromJson(data);
      // list = teamReportData.data.level1;
      // teamReport.value = teamReportData.data;
      // if (teamReportData.status == true) {
      //   print(teamReportData.data);
      //   // records.value = list.data!;
      //   // for (int i = 0; i < list.data!.length; i++) {
      //   //   if (list.data![i].taskStatus == null) {
      //   //     picked.value.add(list.data![i]);
      //   //   } else if (list.data[i].taskStatus!.contains("0")) {
      //   //     pending.value.add(list.data![i]);
      //   //   }
      //   // }
      // } else {
      //   Get.snackbar("Message", "Something went wrong!",
      //       barBlur: 0, snackPosition: SnackPosition.TOP);
      // }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
