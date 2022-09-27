import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Model/profile_model.dart';
import 'package:lets_earn/Services/remote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  // var records = <RecordList>[].obs;
  var profile = <ProfileBalance>[].obs;
  var isLoading = true.obs;
  var url = "".obs;
  File? file;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void onInit() async {
    await getRecords();
    isLoading(false);
    super.onInit();
  }

  Future getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map body = {"user_id": "$uid"};
    try {
      var data = await RemoteService.post(key: "profile", body: body);
      var res = profileModelFromJson(data);
      if (res.status!) {
        profile.value = res.balance!;
        url.value = res.url!;
        nameController.text = res.balance![0].name!;
        emailController.text = res.balance![0].email!;
        phoneController.text = res.balance![0].phone!;
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

  Future pickFile() async {
    // final prefs = await SharedPreferences.getInstance();
    // var uid = prefs.getString("uId");
    // Map<String, String> body = {'user_id': '$uid', 'task_id': taskId};
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File _file = File(result.files.single.path!);
      file = _file;
      update();
      // refresh();
      // var response = await RemoteService.multipart(
      //     key: "youtube-task-uploader",
      //     path: file.path,
      //     file: file,
      //     body: body);
      // Get.snackbar("Message", response["message"],
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: Constants.lightBlue);
    } else {
      // User canceled the picker
    }
  }

  Future uploadFile(File? file) async {
    final prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uId");
    Map<String, String> body = {
      'user_id': '$uid',
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text
    };
    var response = await RemoteService.multipart(
      key: "profile-edit",
      path: file?.path,
      file: file,
      body: body,
    );
    if (response["status"]) {
      getRecords();
    }
    Get.snackbar("Message", response["message"],
        snackPosition: SnackPosition.TOP,
        backgroundColor: Constants.lightBlue);
  }
}
