import 'package:explore/shared/utils/export.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textColor,
    this.family = kLexend,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;
  final String? family;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor ?? appColors.primaryColor,
        fontFamily: family,
      ),
    );
  }
}