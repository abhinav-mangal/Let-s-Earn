import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/Widgets/title.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/purchase_controller.dart';
import 'package:lets_earn/Screens/purchase_screem_2.dart';

// ignore: must_be_immutable
class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  bool showButton = false;
  final _formKey = GlobalKey<FormState>();

  PurchaseController controller = Get.put(PurchaseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: SafeArea(
        child: Scaffold(
            // persistentFooterButtons: [
            //   Visibility(
            //     visible: showButton,
            //     child: GestureDetector(
            //         onTap: () {
            //           upiSubmitDialogue(context);
            //         },
            //         child: const CustTitle(title: "Submit Info")),
            //   ),
            // ],
            body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustTitle(
                      title: "Purchase",
                      noBorder: true,
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Get.to(PurchaseScreen2());
                      },
                      child: CustTitle(
                        title: "GooglePay",
                        noBorder: true,
                        color: Colors.white,
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset("assets/google.png", scale: 25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Get.to(PurchaseScreen2());
                      },
                      child: CustTitle(
                        title: "PhonePay",
                        noBorder: true,
                        color: Colors.white,
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset("assets/phonepe.png", scale: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Get.to(PurchaseScreen2());
                      },
                      child: CustTitle(
                        title: "Paytm",
                        noBorder: true,
                        color: Colors.white,
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset("assets/paytm.png", scale: 15),
                        ),
                      ),
                    ),
                  ],
                );
        })),
      ),
    );
  }

  upiInfoDialogue(BuildContext context) {
    // set up the buttons
    Widget shareButton = TextButton(
      child: const Text("Buy Now"),
      onPressed: () {
        Get.back();
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Get.back(),
    );
    Widget continueButton = TextButton(
        child: const Text("Copy UPI"),
        onPressed: () =>
            Clipboard.setData(ClipboardData(text: controller.address.string))
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("UPI Id coppied"))))
                .then((value) => Get.back()));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("UPI Info"),
      // content: TextFormField(
      //   controller: amountController,
      //   keyboardType: TextInputType.number,
      // ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(controller.message.string),
          const SizedBox(height: 20),
          SelectableText(controller.account.string),
          const SizedBox(height: 10),
          SelectableText(controller.address.string),
        ],
      ),
      actions: [
        cancelButton,
        // shareButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) => setState(
          () => showButton = true,
        ));
  }

  upiSubmitDialogue(BuildContext context) {
    // set up the buttons
    // Widget shareButton = TextButton(
    //   child: const Text("Buy Now"),
    //   onPressed: () {
    //     Get.back();
    //   },
    // );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Get.back(),
    );
    Widget continueButton =
        TextButton(child: const Text("Copy UPI"), onPressed: () {});

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("UPI Info"),
      content: Form(
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
              decoration: const InputDecoration(hintText: "Amount"),
            ),
            TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "UTR required";
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
                  title: "Upload Screenshot",
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
      actions: [
        cancelButton,
        // shareButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
