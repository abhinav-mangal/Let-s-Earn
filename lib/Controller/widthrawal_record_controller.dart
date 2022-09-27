import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/help_centre_model.dart';
import 'package:lets_earn/Model/withdrawal_record_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidthrawalRecordController extends GetxController {
  var isLoading = true.obs;
  var widhrawalRecordList = <WidhrawalRecordData>[].obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  Future getData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("uId");
      Map body = {"user_id": "$uid"};
      var data = await RemoteService.post(key: "withdrawl-record", body: body);
      var res = widhrawalRecordModelFromJson(data);
      if (res.status!) {
        widhrawalRecordList.value = res.data!;
      } else {
        Get.snackbar("Message", res.message!,
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
