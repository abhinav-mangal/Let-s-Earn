import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Controller/membership_controller.dart';
import 'package:lets_earn/Model/membership_model.dart';

class MemberShipScreen extends StatelessWidget {
  MemberShipScreen({Key? key}) : super(key: key);
  final membershipController = Get.put(MembershipController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustTitle(title: "VIP Membership"),
              const SizedBox(height: 20),
              _body(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Obx(() {
      List<MembershipData> data = membershipController.membershipList;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "VIP${data[index].vipNo}:${data[index].price}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("Daily mission : ${data[index].dailyMission}"),
                        Text("Validity period (day) : ${data[index].validity}"),
                        Text(
                            "Mission commission : ${data[index].missionCommission}"),
                        Text("Daily income : ${data[index].dailyIncome}"),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          FontAwesomeIcons.crown,
                          color: Color(0xFFF7B744),
                          size: 35,
                        ),
                        Text("LV.${data[index].vipNo}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: "Message",
                                content: const Text(
                                    "Are you sure you want to purchase and upgrade"),
                                actions: [
                                  TextButton(
                                    child: const Text("cancel"),
                                    onPressed: () => Get.back(),
                                  ),
                                  TextButton(
                                      child: const Text("Ok"),
                                      onPressed: () async {
                                        Get.back();
                                        await membershipController
                                            .buyMembership(
                                                id: data[index].vipNo)
                                            .then((value) => Get.defaultDialog(
                                                middleText: membershipController
                                                    .message.string,
                                                cancel: TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: const Text("ok"))));
                                      }),
                                ]);
                          },
                          child: const Card(
                              color: Color(0xFF45B6F8),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Purchase and \n upgrade now",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )),
                        )
                      ],
                    )
                  ]),
            ),
          );
        },
      );
    });
  }
}
