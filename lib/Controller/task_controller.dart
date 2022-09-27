import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Controller/records_controller.dart';
import 'package:lets_earn/Model/task_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController extends GetxController {
  var isLoading = true.obs;
  var taskList = <TaskData>[].obs;
  var vipLevel = "".obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  Future getData() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      Map body = {"user_id": "${pref.getString('uId')}"};
      var value = await RemoteService.post(key: "show-task", body: body);
      var tasks = taskModalFromJson(value);
      vipLevel.value = tasks.vipLevel.toString();
      taskList.value = tasks.data;
      if (tasks.status) {
        isLoading(false);
      } else {
        isLoading(false);
        Get.snackbar("Message", tasks.message,
            barBlur: 1, snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future pickTask({required String id}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Map body = {"user_id": "${pref.getString('uId')}", "task_id": id};
    try {
      var value = await RemoteService.post(key: "pick-task", body: body);
      var res = json.decode(value);
      await getData();
      RecordController cnt = Get.find();
      cnt.update();
      cnt.getRecords();
      Get.defaultDialog(
        title: "Message",
        content: const Text("Task Picked Successfully"),
        cancel: TextButton(
          child: const Text("Ok"),
          onPressed: () => Get.back(),
        ),
      );
      return res;
    } catch (e) {
      Get.snackbar("Message", "Something went wrong!",
          barBlur: 1, snackPosition: SnackPosition.TOP);
      return false;
    }
  }
}
