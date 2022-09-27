import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_earn/Constants/constants.dart';

import '../Controller/signUp_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Let's earn",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => Get.toNamed("/SignInScreen"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Alredy have one? ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54),
                ),
                Text(
                  "Log in here",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          _textField(
            title: "Name",
            controller: signUpController.name,
            validator: (v) {
              if (v!.isEmpty) {
                return "Enter your Name";
              } else {
                return null;
              }
            },
          ),
          _textField(
              title: "Phone Number",
              controller: signUpController.phoneNumber,
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v!.length != 10) {
                  return "Enter a 10 digit phone number";
                } else {
                  return null;
                }
              }),
          _textField(
            title: "Password",
            obscureText: _isVisible,
            controller: signUpController.password,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                icon: _isVisible == true
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined)),
            validator: (v) {
              if (v!.isEmpty) {
                return "Enter your Password";
              } else {
                return null;
              }
            },
          ),
          _textField(
            title: "Referal Code",
            controller: signUpController.referralCode,
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUpController.signUp();
                    }
                  },
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
