import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lets_earn/Constants/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uId = prefs.getString('uId');
  String? phone = prefs.getString('userContact');
  runApp(MyApp(
    initialRoutes:
        uId == null || phone == null ? "/SignUpScreen" : "/TabBarController",
  ));
}

class MyApp extends StatefulWidget {
  final String? initialRoutes;
  const MyApp({Key? key, this.initialRoutes}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Let's Earn",
      initialRoute: widget.initialRoutes,
      getPages: Routes.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
    );
  }
}
