import 'package:flutter/material.dart';
import 'package:lets_earn/Screens/signin_screen.dart';
import 'package:lets_earn/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referalCode = TextEditingController();

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
        Text(
          "Alredy have one? Log in here",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Constants.primaryColor),
        ),
        const SizedBox(height: 15),
        _textField(title: "Name", controller: _name),
        _textField(title: "Phone Number", controller: _phoneNumber),
        _textField(title: "Password", obscureText: true, controller: _password),
        _textField(title: "Referal Code", controller: _referalCode),
      ],
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Constants.primaryColor),
                  minimumSize: MaterialStateProperty.all(const Size(0, 50))),
              child: const Text(
                "Sign up",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(
      {required TextEditingController controller,
      required String title,
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
