// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// MARK: - App Text Styles
class AppTextStyles {
  final String fontFamily;

  AppTextStyles(this.fontFamily);

  TextStyle get font_40 => _getTextStyle(40);
  TextStyle get font_38 => _getTextStyle(38);
  TextStyle get font_36 => _getTextStyle(36);
  TextStyle get font_34 => _getTextStyle(34);
  TextStyle get font_32 => _getTextStyle(32);
  TextStyle get font_30 => _getTextStyle(30);
  TextStyle get font_28 => _getTextStyle(28);
  TextStyle get font_26 => _getTextStyle(26);
  TextStyle get font_24 => _getTextStyle(24);
  TextStyle get font_22 => _getTextStyle(22);
  TextStyle get font_20 => _getTextStyle(20);
  TextStyle get font_18 => _getTextStyle(18);
  TextStyle get font_16 => _getTextStyle(16);
  TextStyle get font_14 => _getTextStyle(14);
  TextStyle get font_12 => _getTextStyle(12);
  TextStyle get font_10 => _getTextStyle(10);
  TextStyle get font_8 => _getTextStyle(8);

  TextStyle _getTextStyle(double fontSize) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.normal,
    );
  }
}
