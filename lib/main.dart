import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lets_earn/Constants/routes.dart';
import 'package:lets_earn/Screens/signin_screen.dart';

import 'Screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Let's Earn",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/SignInScreen",
      getPages: [
        Routes.signIn,
        Routes.signUp,
      ],
    );
  }
}
