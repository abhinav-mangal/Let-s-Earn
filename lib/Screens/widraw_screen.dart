import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/home_controller.dart';
import 'package:lets_earn/Controller/widraw_controller.dart';

class WidrawScreen extends StatelessWidget {
  const WidrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: SafeArea(
        child: Scaffold(body: Obx(() {
          WidrawController controller = Get.put(WidrawController());
          HomeController cnt = Get.put(HomeController());
          bool isLoding = controller.isLoading.value;
          return RefreshIndicator(
            onRefresh: () => cnt.getEarnings(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CustTitle(
                    title: "Withdraw",
                    noBorder: true,
                  ),
                  const SizedBox(height: 40),
                  GetBuilder<HomeController>(
                    init: HomeController(),
                    initState: (_) {},
                    builder: (cont) {
                      return Text(
                        "Total amount :-${cont.totalEarnings}",
                        style: const TextStyle(fontSize: 20),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Amount to be withdraw",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75),
                    child: TextFormField(
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter Amount",
                        prefixText: "Rs.",
                        prefixStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        CustButton(
                          isLoading: isLoding,
                          title: "Withdraw Now",
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            controller.getData();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Note: Minimum withdrawal limit is 100rs and withdrawal after the membership is purchased.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        })),
      ),
    );
  }
}
