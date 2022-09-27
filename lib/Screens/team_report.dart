import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/team_report_controller.dart';

class TeamReportScreen extends StatelessWidget {
  final controller = Get.put(TeamReportController());
  TeamReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: Constants.decoration,
        child: SafeArea(
          child: Scaffold(
            body: Obx(() {
              var data = controller.teamReport;
              bool isLoading = controller.isLoading.value;
              return isLoading == false
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          _header(data),
                          _body(data),
                          _footer(context),
                        ],
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }

  Widget _header(data) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CustTitle(title: "Team Report", noBorder: true),
        const SizedBox(height: 10),
        const Text(
          "Total team balance",
          style: TextStyle(fontSize: 20),
        ),
        Text("Rs. ${controller.teamReport!.teamBalance}",
            style: const TextStyle(fontSize: 22, color: Colors.red))
      ],
    );
  }

  Widget _body(data) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _card(
              "Total team tops up", "Rs. ${controller.teamReport!.teamTopUp}"),
          _card("Team total withdrawal",
              "Rs. ${controller.teamReport!.teamWithdrawl}"),
          _card("Your team", "${controller.teamReport!.yourTeam}"),
          _card("Successful referrals",
              "${controller.teamReport!.successfullReferrals}"),
        ],
      ),
    );
  }

  Widget _footer(context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.white,
          child: TabBar(
              labelColor: Constants.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "First Level"),
                Tab(text: "Second Level"),
                Tab(text: "Third Level"),
              ]),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 400,
          child: TabBarView(children: [
            level1(),
            level2(),
            level3(),
            // levels(),
          ]),
        ),
      ],
    );
  }

  Widget level1() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.teamReport!.level1.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            margin: EdgeInsets.zero,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.teamReport!.level1[index].phone,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "VIP ${controller.teamReport!.level1[index].level}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Rs. ${controller.teamReport!.level1[index].balance}",
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ]),
            ),
          );
        });
  }

  Widget level2() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.teamReport!.level2.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            margin: EdgeInsets.zero,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.teamReport!.level2[index]["phone"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "VIP ${controller.teamReport!.level2[index]['level']}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Rs. ${controller.teamReport!.level2[index]['balance']}",
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ]),
            ),
          );
        });
  }

  Widget level3() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.teamReport!.level3.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            margin: EdgeInsets.zero,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.teamReport!.level3[index]["phone"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "VIP ${controller.teamReport!.level3[index]['level']}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Rs. ${controller.teamReport!.level3[index]['balance']}",
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ]),
            ),
          );
        });
  }

  Widget _card(String title, String amount) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                amount,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              )
            ],
          )),
    );
  }
}
