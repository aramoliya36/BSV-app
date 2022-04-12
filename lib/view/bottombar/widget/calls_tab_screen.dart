import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/view/call/voice_call_time_page.dart';
import 'package:consultancy/view/callHistory/recent_call_Screen.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/newCall/new_call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

BottomController homeController = Get.find();

Widget callTabScreen() {
  print("..>>>>>>${homeController.selectedScreen.value}");
  switch (homeController.selectedScreen.value) {
    case 'RecentCallScreen':
      return RecentCallScreen();
      break;
    case 'NewCallScreen':
      return NewCallScreen();
      break;
    case 'VoiceCallTimeScreenWidget':
      return VoiceCallTimeScreenWidget();
      break;
    default:
      return RecentCallScreen();
  }
}
