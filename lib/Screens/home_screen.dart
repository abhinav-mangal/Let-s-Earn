import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/home_controller.dart';
import 'package:lets_earn/Controller/task_controller.dart';
import 'package:lets_earn/Model/achivements_model.dart';
import 'package:lets_earn/tab_bar_controller.dart';

import '../Constants/Widgets/Button.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());
  final controller = Get.put(TaskController());
  List<String>? items;
  List<AchievementsList> achivements = [];
  List<String> refferal = [];
  String refferalMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            bool isLoading = homeController.isLoading.value;
            items = homeController.banner;
            achivements = homeController.achivements;
            refferal = homeController.refferal;
            refferalMessage = homeController.refferalMessage.string;
            return isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => homeController.getEarnings(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _header(),
                          const SizedBox(height: 20),
                          _carouselSlider(),
                          const SizedBox(height: 20),
                          _body(context),
                          _footer(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 25, bottom: 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF335DBA), Color(0xFFD1587F)])),
            child: Column(
              children: [
                const Text(
                  "Total Earning",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  homeController.totalEarnings.string,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constants.primaryColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _carouselSlider() {
    return CarouselSlider(
      items: items!.map((e) {
        return Builder(builder: (context) {
          return Image.network(e);
        });
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CustButton(
                title: "Add Money",
                onPressed: () => Get.toNamed("/PurchaseScreen"),
              ),
              const SizedBox(width: 16),
              CustButton(
                  title: "Withdraw",
                  onPressed: () => Get.toNamed("/WidrawScreen")),
            ],
          ),
          const SizedBox(height: 10),
          _socialButton(
              title: "Youtube",
              titleColor: Colors.red,
              icon: const Icon(FontAwesomeIcons.youtube,
                  color: Colors.red, size: 50),
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TabBarController(index: 1)),
                  (Route<dynamic> route) => false)),
          _socialButton(
              title: "Instagram",
              titleColor: Constants.instagram,
              icon: Icon(FontAwesomeIcons.instagramSquare,
                  color: Constants.instagram, size: 50),
              onTap: () => Get.defaultDialog(
                  title: "Coming Soon",
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Hang thight! this feature is yet to launch",
                      textAlign: TextAlign.center,
                    ),
                  ))),
          _socialButton(
              title: "Facebook",
              titleColor: Constants.facebook,
              icon: Icon(
                FontAwesomeIcons.facebookSquare,
                color: Constants.facebook,
                size: 50,
              ),
              onTap: () => Get.defaultDialog(
                  title: "Coming Soon",
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Hang thight! this feature is yet to launch",
                      textAlign: TextAlign.center,
                    ),
                  ))),
          const SizedBox(height: 10),
          _inviteFriends(context),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Get.toNamed("/InvestmentScreen");
            },
            child: Image.asset("assets/investment.png"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              children: const [
                Text(
                  "Member Score board",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: CarouselSlider(
              options: CarouselOptions(
                height: Get.height * .650,
                viewportFraction: 0.12,
                scrollDirection: Axis.vertical,
                autoPlay: true,
                reverse: true,
              ),
              items: achivements.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(i.image),
                      ),
                      title: const Text("Congrates",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i.name),
                          Row(
                            children: [
                              const Text("Current level:-"),
                              const SizedBox(width: 5),
                              Text(
                                "VIP${i.vipNo}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("+${i.amount}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                          const Text("Today's earning",
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8), color: Colors.white),
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: achivements.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Column(
          //         children: [
          //           ListTile(
          //             leading: CircleAvatar(
          //               backgroundImage: NetworkImage(achivements[index].image),
          //             ),
          //             title: const Text("Congrates",
          //                 style: TextStyle(
          //                     fontSize: 16, fontWeight: FontWeight.bold)),
          //             subtitle: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(achivements[index].name),
          //                 Row(
          //                   children: [
          //                     const Text("Current level:-"),
          //                     const SizedBox(width: 5),
          //                     Text(
          //                       "VIP${achivements[index].vipNo}",
          //                       style: const TextStyle(
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.red),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             trailing: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.end,
          //               children: [
          //                 Text("+${achivements[index].amount}",
          //                     style: const TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.red,
          //                     )),
          //                 const Text("Today's earning",
          //                     style: TextStyle(
          //                       color: Colors.red,
          //                     )),
          //               ],
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _inviteFriends(context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => showAlertDialog(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Constants.accentBlue),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    "Invite Your Friends",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget shareButton = TextButton(
      child: const Text("Share"),
      onPressed: () {
        FlutterShare.share(
            title: "Refferal Code", text: "${refferal[0]}\n\n$refferalMessage");
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Get.back(),
    );
    Widget continueButton = TextButton(
        child: const Text("Copy"),
        onPressed: () => Clipboard.setData(ClipboardData(text: refferal[0]))
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Refferal Code coppied"))))
            .then((value) => Get.back()));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Refferal Code"),
      content: SelectableText("Your refferal code: ${refferal[0]}"),
      actions: [
        cancelButton,
        shareButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Padding _socialButton(
      {required Widget icon,
      required String title,
      Color? titleColor,
      void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: ListTile(
          dense: true,
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w900, color: titleColor),
            ),
          ),
        ),
      ),
    );
  }
}
