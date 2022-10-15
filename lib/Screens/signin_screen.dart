import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:lets_earn/Controller/signin_controller.dart';
import 'package:lets_earn/Constants/constants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final signInController = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => Get.toNamed("/SignUpScreen"),
              child: const Text(
                "Still new here? Create new accout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black54),
              ),
            ),
            const SizedBox(height: 15),
            _textField(
                title: "Phone Number",
                controller: signInController.phoneNumber,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumberNational],
                validator: (v) {
                  if (v!.length != 10) {
                    return "Enter a 10 digit phone number";
                  } else {
                    return null;
                  }
                }),
            Obx(
              () => _textField(
                  title: "Password",
                  obscureText: signInController.isVisible.value,
                  controller: signInController.password,
                  autofillHints: [AutofillHints.password],
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (signInController.isVisible.value == false) {
                          signInController.isVisible.value = true;
                        } else if (signInController.isVisible.value == true) {
                          signInController.isVisible.value = false;
                        }
                      },
                      icon: signInController.isVisible.value == true
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter your Password";
                    } else {
                      return null;
                    }
                  }),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed("/ForgotPasswordScreen");
                    },
                    child: const Text("Forgot Password?"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Obx(() => Column(
            children: [
              _button(
                  isLoading: signInController.isLoading.value,
                  title: "Login",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signInController.signIn();
                    }
                  }),
              const SizedBox(height: 20),
              // _button(title: "Download App"),
            ],
          )),
    );
  }

  Widget _button(
      {required String title,
      void Function()? onPressed,
      bool isLoading = false}) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Constants.primaryColor),
                minimumSize: MaterialStateProperty.all(const Size(0, 50))),
            child: isLoading
                ? const SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _textField(
      {required TextEditingController controller,
      required String title,
      Widget? suffixIcon,
      TextInputType? keyboardType,
      String? Function(String?)? validator,
      Iterable<String>? autofillHints,
      void Function()? onEditingComplete,
      bool obscureText = false}) {
    return AutofillGroup(
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
            autofillHints: autofillHints,
            onEditingComplete: onEditingComplete,
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
                suffixIcon: suffixIcon),
          ),
        ],
      ),
    );
  }
}
