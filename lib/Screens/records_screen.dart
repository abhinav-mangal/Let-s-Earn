import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Controller/records_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/Widgets/Button.dart';
import '../Constants/constants.dart';
import '../Model/record_model.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final recordController = Get.put(RecordController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height / 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const CustTitle(title: "Records"),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TabBar(
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelColor: Colors.red,
                          isScrollable: true,
                          tabs: [
                            Tab(text: "Picked"),
                            Tab(text: "Pending"),
                            Tab(text: "Completed"),
                            Tab(text: "Failed"),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            // flexibleSpace: _header(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              List<Completed> completed = recordController.completed;
              List<Picked> picked = recordController.picked;
              List<Pending> pending = recordController.pending;
              List<Failed> failed = recordController.failed;
              bool isLoading = recordController.isLoading.value;
              bool isBtLoading = recordController.isBtLoading.value;

              return TabBarView(children: [
                _list(picked, isLoading, true, isBtloaded: isBtLoading),
                _list(pending, isLoading, false),
                _list(completed, isLoading, false),
                _list(failed, isLoading, true),
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Widget _list(List data, bool isLoading, bool isUploaded, {bool? isBtloaded}) {
    return recordController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : data.isEmpty
            ? const Center(child: Text("Pick some task!"))
            : RefreshIndicator(
                onRefresh: () => recordController.getRecords(),
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text("Bonus - ${data[index].bonus}"),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.youtube,
                                    color: Colors.red, size: 75),
                                const SizedBox(width: 10),
                                CustButton(
                                  title: "Link",
                                  fontSize: 22,
                                  color: isUploaded
                                      ? Constants.accentBlue
                                      : Colors.grey,
                                  onPressed: isUploaded
                                      ? () {
                                          _launchUrl(data[index].youtubeLink);
                                        }
                                      : null,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Task no.${data[index].youtubeLinkSno}",
                                  style: const TextStyle(fontSize: 12),
                                )),
                                const SizedBox(width: 20),
                                isUploaded
                                    ? CustButton(
                                        isLoading:
                                            index != recordController.index
                                                ? false
                                                : true,
                                        title: "Upload",
                                        fontSize: 12,
                                        width: 0,
                                        height: 30,
                                        color: Constants.mildBlue,
                                        onPressed: () {
                                          recordController.pickFile(
                                              "${data[index].taskId}", index);
                                        })
                                    : Container(),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ]),
                        ),
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
