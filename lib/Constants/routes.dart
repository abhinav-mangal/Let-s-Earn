import 'package:get/get.dart';
import 'package:lets_earn/Screens/home_screen.dart';
import 'package:lets_earn/Screens/membership_screen.dart';
import 'package:lets_earn/Screens/profile_screen.dart';
import 'package:lets_earn/Screens/records_screen.dart';
import 'package:lets_earn/Screens/task_screen.dart';
import 'package:lets_earn/tab_bar_controller.dart';

import '../Screens/signin_screen.dart';
import '../Screens/signup_screen.dart';

class Routes {

  static List<GetPage<dynamic>>? pages = [
    GetPage(name: "/SignInScreen", page: () => SignInScreen()),
    GetPage(name: '/SignUpScreen', page: () => SignUpScreen()),
    GetPage(name: '/TabBarController', page: () => const TabBarController()),
    GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
    GetPage(name: '/TaskScreen', page: () => const TaskScreen()),
    GetPage(name: '/MemberShipScreen', page: () => const MemberShipScreen()),
    GetPage(name: '/RecordsScreen', page: () => const RecordsScreen()),
    GetPage(name: '/ProfileScreen', page: () => const ProfileScreen()),
  ];
}
