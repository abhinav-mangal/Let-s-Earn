import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/income_expenditure_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeExpenditureController extends GetxController {
  var isLoading = true.obs;
  var incomeExpendicture = <IncomeExpendictureData>[].obs;

  @override
  void onInit() async {
    await getData();
    isLoading(false);
    super.onInit();
  }

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data =
          await RemoteService.post(key: "income-expenditure", body: body);
      var res = incomeExpendictureModelFromJson(data);
      if (res.status!) {
        incomeExpendicture.value = res.data!;
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
