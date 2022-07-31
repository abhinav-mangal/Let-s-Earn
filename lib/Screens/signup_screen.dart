import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/constants.dart';

import '../Controller/signUp_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 75),
              _header(),
              _body(),
              const SizedBox(height: 25),
              _footer(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Image.asset("assets/logo1.png");
  }

  Widget _body() {
    return Column(
      children: [
        const Text(
          "Let's earn",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => Get.toNamed("/SignInScreen"),
          child: Text(
            "Alredy have one? Log in here",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Constants.primaryColor),
          ),
        ),
        const SizedBox(height: 15),
        _textField(title: "Name", controller: signUpController.name),
        _textField(
            title: "Phone Number", controller: signUpController.phoneNumber, keyboardType: TextInputType.phone),
        _textField(
            title: "Password",
            obscureText: true,
            controller: signUpController.password, keyboardType: TextInputType.visiblePassword),
        _textField(
            title: "Referal Code", controller: signUpController.referralCode),
      ],
    );
  }

  Widget _footer() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => signUpController.signUp(),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Constants.primaryColor),
                      minimumSize:
                          MaterialStateProperty.all(const Size(0, 50))),
                  child: signUpController.isLoading.value
                      ? const SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _textField(
      {required TextEditingController controller,
      required String title,
      TextInputType? keyboardType,
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
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(width: 2)),
            ),
          ),
        ],
      ),
    );
  }
}
