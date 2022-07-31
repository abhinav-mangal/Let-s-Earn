import 'package:flutter/material.dart';

class Constants {
  static Color primaryColor = const Color(0xFFF49F3F);
  static Color lightBlue = const Color(0xFFEDF3F7);
  static Color darkBlue = const Color(0xFF6AA5CF);
  
  static Decoration decoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Constants.darkBlue, Constants.lightBlue],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter));
}
