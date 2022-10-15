import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/purchase_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/remote_service.dart';

class PurchaseController extends GetxController {
  // var records = <RecordList>[].obs;
  // var pending = <Pending>[].obs;
  // var picked = <Picked>[].obs;
  // var completed = <Completed>[].obs;
  // var failed = <Failed>[].obs;
  var account = "".obs;
  var address = "".obs;
  var message = "".obs;
  var isLoading = true.obs;
  var isBTLoading = false.obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController vpaController = TextEditingController();

  @override
  void onInit() async {
    await getUpi();
    isLoading(false);
    super.onInit();
  }

  Future getUpi() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {
      "user_id": "$uid",
    };
    try {
      var data = await RemoteService.post(key: "deposit", body: "");
      var res = purchaceModelFromJson(data);
      account.value = res.account;
      address.value = res.address;
      message.value = res.message;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future pickFile() async {
    isBTLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map<String, String> body = {
      'user_id': '$uid',
      'method': 'upi',
      'amount': amountController.text,
      'utr': vpaController.text,
    };
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      var response = await RemoteService.multipart(
          key: "deposit", path: file.path, file: file, body: body);
      Get.defaultDialog(
          title: "Message",
          content: Text(response["message"]),
          cancel: TextButton(
              onPressed: () => Get.offAllNamed("/TabBarController"),
              child: const Text("ok")));
      isBTLoading(false);
    } else {
      isLoading(false);
      // User canceled the picker
    }
  }
}
