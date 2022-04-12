import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/notification/notification_setting_screen.dart';
import 'package:consultancy/view/notification/notifications.dart';
import 'package:consultancy/view/profileSetting/account_setting.dart';
import 'package:consultancy/view/profileSetting/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

BottomController homeController = Get.find();

Widget notificationTabScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserHomeWidget':
      return UserHomeWidget();
      break;
    case 'EditProfileApp':
      return EditProfileApp();
      break;
    case 'AccountScreen':
      return AccountScreen();
      break;
    case 'NotificationSettingScreen':
      return NotificationSettingScreen();
      break;
    case 'Notifications':
      return Notifications();
      break;

    default:
      return NotificationSettingScreen();
  }
}
