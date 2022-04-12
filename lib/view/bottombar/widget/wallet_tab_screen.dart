import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/old_charges.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/newChat/newChat.dart';
import 'package:consultancy/view/profileSetting/edit_profile_screen.dart';
import 'package:consultancy/view/profileSetting/show_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:consultancy/view/wallet/buy_bitcoin.dart';

import '../../../CHNAGE_CONNNN.dart';

BottomController homeController = Get.find();

Widget walletScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserHomeWidget':
      return UserHomeWidget();
      break;
    case 'EditProfileApp':
      return EditProfileApp();

      break;
    case 'ShowProfileApp':
      return ShowProfileApp();
      break;
    case 'AppCharges':
      return AppCharges();
      break;
    case 'OldAppCharges':
      return OldAppCharges();
      break;
    case 'BitCoinScreen':
      return BitCoinScreen();
      break;
    case 'NewChatScreen':
      return NewChatScreen1();
      break;

    default:
      return BitCoinScreen();
  }
}
