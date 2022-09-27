import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/widthrawal_record_controller.dart';
import 'package:lets_earn/Model/withdrawal_record_model.dart';

class WidthrawalRecordScreen extends StatelessWidget {
  WidthrawalRecordScreen({Key? key}) : super(key: key);

  WidthrawalRecordController controller = Get.put(WidthrawalRecordController());
  List<WidhrawalRecordData> data = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: Obx(() {
          data = controller.widhrawalRecordList;
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const CustTitle(title: "Withdrawal record"),
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
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Date",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Status",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Amount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[i].createdAt!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        data[i].approvedStatus!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        data[i].transactionAmount!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
