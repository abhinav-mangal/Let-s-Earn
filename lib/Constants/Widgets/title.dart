import 'package:flutter/material.dart';

import '../constants.dart';

class CustTitle extends StatelessWidget {
  final String title;
  final bool? noBorder;
  final Color? color;
  final Widget? widget;
  const CustTitle(
      {Key? key,
      required this.title,
      this.noBorder = false,
      this.color,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
          borderRadius: noBorder == false ? BorderRadius.circular(8) : null,
          color: color ?? Constants.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget ?? Container(),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
