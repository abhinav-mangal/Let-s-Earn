import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/Button.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/purchase_controller.dart';

class PurchaseScreen2 extends StatelessWidget {
  PurchaseScreen2({Key? key}) : super(key: key);
  PurchaseController controller = Get.put(PurchaseController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Constants.decoration,
        child: Scaffold(body: Obx(() {
          return SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 50),
              const CustTitle(
                title: "Purchase",
                noBorder: true,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      controller.message.string,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(controller.account.string,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(
                            onPressed: () => Clipboard.setData(ClipboardData(
                                    text: controller.account.string))
                                .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content:
                                            Text("Account name coppied")))),
                            icon: const Icon(Icons.copy))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(controller.address.string,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        IconButton(
                            onPressed: () => Clipboard.setData(ClipboardData(
                                    text: controller.address.string))
                                .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text("UPI Id coppied")))),
                            icon: const Icon(Icons.copy))
                      ],
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Amount that you have deposited";
                              }
                              return null;
                            },
                            controller: controller.amountController,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: "Amount"),
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null ||
                                  text.isEmpty ||
                                  text.length < 12) {
                                return "12 digit UTR number required";
                              }
                              return null;
                            },
                            controller: controller.vpaController,
                            // keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: "UTR"),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              CustButton(
                                isLoading: controller.isBTLoading.value,
                                title: "Upload Screenshot & Submit",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.pickFile();
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          );
        })));
  }
}
