import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle appMediumTextStyle(
      {double? size, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: size,
      color: color,
    );
  }
}
