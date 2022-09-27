import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/record_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';
import '../Services/remote_service.dart';

class RecordController extends GetxController {
  // var records = <RecordList>[].obs;
  var pending = <Pending>[].obs;
  var picked = <Picked>[].obs;
  var completed = <Completed>[].obs;
  var failed = <Failed>[].obs;
  var isLoading = false.obs;
  var isBtLoading = false.obs;
  int? index;

  @override
  void onInit() async {
    await getRecords();
    super.onInit();
  }

  Future getRecords() async {
    isLoading(true);
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data = await RemoteService.post(key: "youtube-task", body: body);
      var list = recordModalFromJson(data);
      if (list.status) {
        picked.value = list.picked!;
        pending.value = list.pending!;
        completed.value = list.completed!;
        failed.value = list.failed!;
        isLoading(false);
      } else {
        Get.snackbar("Message", list.message,
            barBlur: 0, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(true);
    }
  }

  Future pickFile(String taskId, int _index) async {
    index = _index;
    update();
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map<String, String> body = {'user_id': '$uid', 'task_id': taskId};
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      isBtLoading(true);
      File file = File(result.files.single.path!);
      var response = await RemoteService.multipart(
          key: "youtube-task-uploader",
          path: file.path,
          file: file,
          body: body);
      Get.snackbar("Message", response["message"],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Constants.lightBlue);
      isBtLoading(false);
      index = null;
      update();
      getRecords();
    } else {
      // User canceled the picker
    }
  }
}
