import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/investment_controller.dart';

import '../Model/investment_model.dart';

class InvestmentScreen extends StatelessWidget {
  InvestmentScreen({Key? key}) : super(key: key);
  final investmentController = Get.put(InvestmentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            List<InvestmentModel> data = investmentController.investmentList;
            bool isLoading = investmentController.isLoading.value;
            return isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(children: [
                        const SizedBox(height: 30),
                        const CustTitle(title: "Financial Products"),
                        const SizedBox(height: 20),
                        _investCard(data, isLoading),
                        const SizedBox(height: 20),
                      ]),
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget _investCard(List<InvestmentModel> data, bool isLoading) {
    return ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _cards(data, index, isLoading);
      },
    );
  }

  Widget _cards(List<InvestmentModel> data, int index, bool isLoading) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data[index].planName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Html(data: data[index].planDescription),
                Text(data[index].paragrapf!)
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Period ${data[index].planPeriod} Days",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "Daily gains ${data[index].planDailyGains}.00%",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  data[index].planGainsDescription,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: "Message",
                        content: const Text("Are you sure you want invest"),
                        actions: [
                          TextButton(
                            child: const Text("cancel"),
                            onPressed: () => Get.back(),
                          ),
                          TextButton(
                              child: const Text("Ok"),
                              onPressed: () async {
                                Get.back();
                                await investmentController.investNow(
                                    planId: data[index].planId);
                              }),
                        ]);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Constants.primaryColor),
                    minimumSize: MaterialStateProperty.all(const Size(20, 30)),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Invest Now",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Total gains Rs. ${data[index].totalGain}",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
