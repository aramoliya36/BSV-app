import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/scheduleScreens/sedual_calander.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

BottomController homeController = Get.find();

Widget calenderScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserHomeWidget':
      return UserHomeWidget();
      break;
    case 'SedualCalander':
      return SedualCalander();
      break;

    default:
      return SedualCalander();
  }
}
