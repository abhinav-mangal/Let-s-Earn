import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/bank_details_controller.dart';

class BankDetailsScreen extends StatelessWidget {
  BankDetailsScreen({Key? key}) : super(key: key);

  BankDetailsController controller = Get.put(BankDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 50),
                    const CustTitle(title: "Bank Details", noBorder: true),
                    _body(),
                    _footer(),
                  ]),
                );
        }),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        const SizedBox(height: 50),
        custTextField(
          controller: controller.bankAccountNoController,
          hintText: "Bank account number",
        ),
        const SizedBox(height: 10),
        custTextField(
          controller: controller.holderNameController,
          hintText: "Bank Holder name",
        ),
        const SizedBox(height: 10),
        custTextField(
            hintText: "IfSC code", controller: controller.ifscCodeController),
        const SizedBox(height: 10),
        custTextField(
            hintText: "Bank branch name",
            controller: controller.branchNameController),
        const SizedBox(height: 10),
        custTextField(
            hintText: "UPI id", controller: controller.upiIdController),
        const SizedBox(height: 10),
        custTextField(
            hintText: "Name", controller: controller.upiNameController),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          CustButton(
            isLoading: controller.isLoading.value,
            title: "Save",
            onPressed: () => controller.editBankDetails(),
          ),
        ],
      ),
    );
  }

  Widget custTextField(
      {required String hintText, TextEditingController? controller}) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
      ),
    );
  }
}
