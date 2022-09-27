import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/help_centre_controller.dart';
import 'package:lets_earn/Model/help_centre_model.dart';

class HelpCentreScreen extends StatelessWidget {
  HelpCentreScreen({Key? key}) : super(key: key);

  HelpCentreController controller = Get.put(HelpCentreController());
  List<HelpCentreData> data = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: Obx(() {
          data = controller.helpCentreList;
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const CustTitle(title: "Help Center"),
                        _body(),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ExpansionTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                title: Text(
                  data[i].question!,
                  style: const TextStyle(fontSize: 20),
                ),
                children: [Text(data[i].answer!)],
              ),
            ),
          ),
        );
      },
    );
  }
}
