import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/view/auths/change_email_screen.dart';
import 'package:consultancy/view/auths/change_mobile_number.dart';
import 'package:consultancy/view/auths/chnage_mobile_otp_screen.dart';
import 'package:consultancy/view/avalibity/availabilty.dart';
import 'package:consultancy/view/callLimitSet/call_screen.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/charge_new_list.dart';
import 'package:consultancy/view/chat/chatUi/rooms.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/newChat/newChat.dart';
import 'package:consultancy/view/notification/notifications.dart';
import 'package:consultancy/view/privacy/privacy_screen.dart';
import 'package:consultancy/view/profile/profile_new.dart';
import 'package:consultancy/view/profileSetting/account_infomation.dart';
import 'package:consultancy/view/profileSetting/account_setting.dart';
import 'package:consultancy/view/profileSetting/app_settings.dart';
import 'package:consultancy/view/profileSetting/delete_screen.dart';
import 'package:consultancy/view/profileSetting/edit_profile_screen.dart';
import 'package:consultancy/view/profileSetting/manage_account_select.dart';
import 'package:consultancy/view/profileSetting/show_profile.dart';
import 'package:consultancy/view/searchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../CHNAGE_CONNNN.dart';

BottomController homeController = Get.find();

Widget chatTabScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserHomeWidget':
      return UserHomeWidget();
      break;
    case 'ShowProfileApp':
      return ShowProfileApp();
      break;
    case 'AppSettings':
      return AppSettings();
      break;
    case 'ManageAccountSelect':
      return ManageAccountSelect();
      break;
    case 'CallScreen':
      return CallScreen();
      break;
    case 'AppCharges':
      return AppCharges();
      break;
    case 'NewList':
      return NewList();
      break;
    case 'Notifications':
      return Notifications();
      break;
    case 'AccountScreen':
      return AccountScreen();
      break;
    case 'AvailabiltyScreen':
      return AvailabiltyScreen();
      break;
    case 'NewChatScreen':
      return NewChatScreen1();
      break;
    case 'PrivacyScreen':
      return PrivacyScreen();
      break;
    case 'ProfileNew':
      return ProfileNew();
      break;
    case 'SearchScreen':
      return SearchScreen();
      break;
    case 'ChangeEmail':
      return ChangeEmail();
      break;
    case 'ChangeCountryPicker':
      return ChangeCountryPicker();
      break;
    case 'OtpScreenChangeNumber':
      return OtpScreenChangeNumber();
      break;
    case 'AccountInformation':
      return AccountInformation();
      break;
    case 'ChatRoom':
      return ChatRoom();
      break;
    case 'DeleteMyAccount':
      return DeleteMyAccount();
      break;

    default:
      return UserHomeWidget();
      break;
  }
}
