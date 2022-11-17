// base theme
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: appColors.primaryColor,
  scaffoldBackgroundColor: appColors.primaryColor,
  
);

const appColors = _AppColors(
  primaryColor: Color(0xff111112),
  secondaryColor: Color(0xffFA7777),
  white: Colors.white,
  blue: Color(0xff537ECC),
  darkGrey: Color(0xff1c1c1e),
  grey: Color(0xff27272a),
  lightGrey: Color(0xff51515e),
);

class _AppColors {
  const _AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.white,
    required this.blue,
    required this.darkGrey,
    required this.grey,
    required this.lightGrey,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color white;
  final Color blue;
  final Color darkGrey;
  final Color grey;
  final Color lightGrey;
}
