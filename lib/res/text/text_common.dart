import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonText {
  /// light weight 300
  static textLightDynamicW300(
      {required String text, Color? textColor, double? textSize}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          color: textColor,
          fontSize: textSize),
    );
  }

  /// medium weight 400
  static textRegularWhiteW400({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: ColorPicker.whiteColor),
    );
  }

  static textRegularW400({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: ColorPicker.hintTextColor),
    );
  }

  static textMediumDynamicColor400(
      {required String text, Color? textColor, double? textSize}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: textColor,
          fontSize: textSize),
    );
  }

  /// medium weight 500
  static textMediumP({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: ColorPicker.hintTextColor),
    );
  }

  static textMediumDynamicColorP(
      {required String text, Color? textColor, double? textSize}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          color: textColor,
          fontSize: textSize),
    );
  }

  static textLargeP({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: ColorPicker.whiteColor),
    );
  }

  /// medium weight 600

  static textSemiBoldP({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: ColorPicker.whiteColor),
    );
  }

  static textSemiBoldDynamicP({
    required String text,
    Color? textColor,
    double? fontSize,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          overflow: overflow,
          color: textColor),
    );
  }

  static textStyleSemiBold600() {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
        color: ColorPicker.whiteColor);
  }

  static textStyleSemiBold600Normal() {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: ColorPicker.whiteColor);
  }

  /// bold weight 700
  static textStyleSemiBold700() {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        decoration: TextDecoration.underline,
        color: ColorPicker.whiteColor);
  }

  static textBold700P({required String text}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 13.sp,
          color: ColorPicker.whiteColor),
    );
  }

  static textBold700PDynamicP(
      {required String text, Color? textColor, double? fontSize}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          color: textColor),
    );
  }
}
