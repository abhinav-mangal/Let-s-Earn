import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Model/task_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);
  final controller = Get.put(TaskController());
  // String vip = "";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Obx(() {
          List<TaskData> data = controller.taskList;
          String vip = controller.vipLevel.string;
          bool isLoading = controller.isLoading.value;
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(80),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60,
                                  color: Constants.primaryColor,
                                  child: const TabBar(
                                      indicatorColor: Colors.white,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      unselectedLabelColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      labelColor: Colors.white,
                                      isScrollable: true,
                                      tabs: [
                                        Tab(text: "Popular"),
                                        Tab(text: "Facebook"),
                                        Tab(text: "YouTube"),
                                        Tab(text: "Instagram"),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Currently you are on",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " VIP$vip",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.primaryColor),
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(children: [
                    _card(data),
                    const Center(child: Text("Coming Soon!")),
                    _card(data),
                    const Center(child: Text("Coming Soon!")),
                  ]));
        }));
  }

  Widget _card(List<TaskData> data) {
    return RefreshIndicator(
      onRefresh: () async => await controller.getData(),
      child: ListView.builder(
        itemCount: data.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "Mission commission : ${data[index].missionCommision}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(FontAwesomeIcons.youtube,
                        color: Colors.red, size: 75),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Like\nSubscribe"),
                    ),
                    CustButton(
                      title: "Pick",
                      color: Constants.accentBlue,
                      onPressed: () =>
                          controller.pickTask(id: data[index].youtubeLinkId),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "Tasks no. ${data[index].youtubeLinkSno}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
