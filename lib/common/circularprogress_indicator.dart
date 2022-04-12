import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:flutter/material.dart';

Widget circularProgress() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(ColorPicker.whiteColor),
  ));
}
