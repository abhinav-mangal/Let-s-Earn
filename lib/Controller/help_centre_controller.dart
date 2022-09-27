import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Model/help_centre_model.dart';
import 'package:lets_earn/Services/remote_service.dart';

class HelpCentreController extends GetxController {
  var isLoading = true.obs;
  var helpCentreList = <HelpCentreData>[].obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  Future getData() async {
    try {
      var data = await RemoteService.get(key: "help-center");
      var res = helpCentreModelFromJson(data);
      if (res.status!) {
        helpCentreList.value = res.data!;
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
