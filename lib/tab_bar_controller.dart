import 'package:flutter/material.dart';
import 'package:lets_earn/Constants/constants.dart';
import 'package:lets_earn/Screens/home_screen.dart';
import 'package:lets_earn/Screens/membership_screen.dart';
import 'package:lets_earn/Screens/profile_screen.dart';
import 'package:lets_earn/Screens/records_screen.dart';
import 'package:lets_earn/Screens/task_screen.dart';

class TabBarController extends StatefulWidget {
  const TabBarController({Key? key}) : super(key: key);

  @override
  State<TabBarController> createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const TaskScreen(),
    const MemberShipScreen(),
    const RecordsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.decoration,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          // backgroundColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: [
            bottomBar(icon: Icons.home, lable: "Home"),
            bottomBar(icon: Icons.task_alt, lable: "Task"),
            bottomBar(icon: Icons.person_pin, lable: "Membership"),
            bottomBar(icon: Icons.receipt_long_rounded, lable: "Record"),
            bottomBar(icon: Icons.menu_rounded, lable: "Profile"),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomBar({IconData? icon, String? lable}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: lable,
    );
  }
}
