import 'package:flutter/material.dart';

class CustButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool? isLoading;
  final String title;
  final Color? color;
  final double? fontSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  const CustButton(
      {Key? key,
      this.onPressed,
      this.isLoading = false,
      required this.title,
      this.color = const Color(0xFFFACF49),
      this.fontSize = 18,
      this.width = 0,
      this.height = 50,
      this.padding,
      this.isExpanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isExpanded == false ? 1 : 0,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
              minimumSize: MaterialStateProperty.all(Size(width!, height!))),
          child: isLoading!
              ? const SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: fontSize),
                ),
        ),
      ),
    );
  }
}
