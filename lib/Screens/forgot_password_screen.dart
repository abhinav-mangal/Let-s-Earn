import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/Widgets/button.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Controller/forgotpassword_controller.dart';

ForgotpasswordController controller = Get.put(ForgotpasswordController());

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Constants.decoration,
        child: Scaffold(body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset("assets/logo1.png"),
                const Text("Let's earn",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                const SizedBox(height: 75),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    !controller.isNewPass.value
                        ? !controller.isOTP.value
                            ? "Enter your registered Email Id."
                            : "We have sent you an OTP to your registered email id"
                        : "Please entre your new password",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                !controller.isNewPass.value
                    ? !controller.isOTP.value
                        ? _textField(
                            controller: controller.email, title: "Email")
                        : _textField(controller: controller.otp, title: "OTP")
                    : _textField(
                        controller: controller.newPass, title: "New Password"),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      CustButton(
                        isLoading: controller.isLoading.value,
                        title: !controller.isNewPass.value
                            ? !controller.isOTP.value
                                ? "Send"
                                : "Verify"
                            : "Confirm",
                        color: Constants.primaryColor,
                        onPressed: () {
                          !controller.isNewPass.value
                              ? !controller.isOTP.value
                                  ? controller.forgotPass()
                                  : controller.verifyOtp()
                              : controller.changePass();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        })));
  }

  Widget _textField(
      {required TextEditingController controller,
      required String title,
      TextInputType? keyboardType,
      String? Function(String?)? validator,
      Widget? suffixIcon,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(title, style: const TextStyle(fontSize: 20)))
            ],
          ),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2, color: Colors.red)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
