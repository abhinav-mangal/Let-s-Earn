import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/income_expenditure_controller.dart';
import 'package:lets_earn/Model/income_expenditure_model.dart';

class IncomeExpenditureScreen extends StatelessWidget {
  IncomeExpenditureScreen({Key? key}) : super(key: key);
  IncomeExpenditureController controller =
      Get.put(IncomeExpenditureController());
  List<IncomeExpendictureData> data = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(body: Obx(() {
        data = controller.incomeExpendicture;
        return controller.isLoading.value
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const CustTitle(
                        title: "Income & expenditure", noBorder: true),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Debite/credit",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "By/from",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Amt",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return Table(children: [
                                TableRow(children: [
                                  Column(children: [
                                    Text(
                                      data[index].createdAt!,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  Column(children: [
                                    Text(
                                      data[index].transactionType!,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  Column(children: [
                                    Text(
                                      data[index].taskType!,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  Column(children: [
                                    Text(
                                      data[index].transactionAmount!,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                ])
                              ]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      })),
    );
  }
}
