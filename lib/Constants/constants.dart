import 'package:flutter/material.dart';

class Constants {
  static Color primaryColor = const Color(0xFFF49F3F);
  static Color lightBlue = const Color(0xFFEDF3F7);
  static Color darkBlue = const Color(0xFF6AA5CF);
  static Color yellow = const Color(0xFFFACF49);
  static Color instagram = const Color(0xFFEC459C);
  static Color facebook = const Color(0xFF1F449C);
  static Color accentBlue = const Color(0xFF45B6F8);

  static Decoration decoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Constants.darkBlue, Constants.lightBlue],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter));
}
