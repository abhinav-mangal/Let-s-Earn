import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/bank_details_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankDetailsController extends GetxController {
  var isLoading = true.obs;

  var bankDetailsData = BankDetailsData().obs;

  TextEditingController bankAccountNoController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController upiNameController = TextEditingController();

  @override
  void onInit() async {
    await getBankDetails();
    super.onInit();
  }

  Future getBankDetails() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      Map body = {"user_id": "${pref.getString('uId')}"};
      var data = await RemoteService.post(key: "bank-details", body: body);
      var res = bankDetailsModelFromJson(data);
      if (res.status!) {
        bankDetailsData.value = res.data!;
        bankAccountNoController.text = res.data!.accountNo!;
        holderNameController.text = res.data!.holderName!;
        ifscCodeController.text = res.data!.ifscCode!;
        branchNameController.text = res.data!.branchName!;
        upiIdController.text = res.data!.upiId!;
        upiNameController.text = res.data!.upiName!;
        isLoading(false);
      } else {
        Get.snackbar("Message", "Something went wrong!",
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void editBankDetails() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      Map body = {
        "user_id": "${pref.getString('uId')}",
        "account_no": bankAccountNoController.text,
        "holder_name": holderNameController.text,
        "ifsc_code": ifscCodeController.text,
        "branch_name": branchNameController.text,
        "upi_id": upiIdController.text,
        "upi_name": upiNameController.text,
      };
      var data = await RemoteService.post(key: "bank-details-edit", body: body);
      var res = json.decode(data);
      if (res["status"] == true) {
        Get.snackbar("Message", res["message"],
            barBlur: 0, snackPosition: SnackPosition.TOP);
        await getBankDetails();
        isLoading(false);
      } else {
        Get.snackbar("Message", "Something went wrong!",
            barBlur: 0, snackPosition: SnackPosition.TOP);
        isLoading(false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
