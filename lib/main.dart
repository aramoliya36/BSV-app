import 'package:consultancy/delet_new_charge.dart';
import 'package:consultancy/view/appProfile/app_profile.dart';
import 'package:consultancy/view/auths/change_mobile_number.dart';
import 'package:consultancy/view/auths/country_pick.dart';
import 'package:consultancy/view/auths/email_sign_screen.dart';
import 'package:consultancy/view/auths/register_screen.dart';
import 'package:consultancy/view/avalibity/availabilty.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/call/profile_Screen_page.dart';
import 'package:consultancy/view/call/voice_call_time_page.dart';
import 'package:consultancy/view/callHistory/recent_call_Screen.dart';
import 'package:consultancy/view/callLimitSet/call_screen.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/by_default_screen.dart';
import 'package:consultancy/view/charges/charge_new_list.dart';
import 'package:consultancy/view/drawer.dart';
import 'package:consultancy/view/homeScreen/user_home_widget.dart';
import 'package:consultancy/view/newCall/new_call.dart';
import 'package:consultancy/view/newChat/newChat.dart';
import 'package:consultancy/view/notification/notifications.dart';
import 'package:consultancy/view/profile/profile.dart';
import 'package:consultancy/view/profile/profile_new.dart';
import 'package:consultancy/view/profileSetting/account_setting.dart';
import 'package:consultancy/view/profileSetting/edit_profile_screen.dart';
import 'package:consultancy/view/profileSetting/show_profile.dart';
import 'package:consultancy/view/profileSetting/manage_account_select.dart';
import 'package:consultancy/view/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'CHNAGE_CONNNN.dart';
import 'ViewModel/app_charge_viewmodel.dart';
import 'ViewModel/app_profile_controller.dart';
import 'ViewModel/calling_screen_controller.dart';
import 'ViewModel/change_country_pick_controller.dart';
import 'ViewModel/charge_new_list_viewmodel.dart';
import 'ViewModel/country_pick_viewmode.dart';
import 'ViewModel/create_wallet_viewmodel.dart';
import 'ViewModel/edit_profile_controller.dart';
import 'ViewModel/get_address_id_tra_viewmodel.dart';
import 'ViewModel/get_balance_viewmodel.dart';
import 'ViewModel/get_wallet_id_viewmodel.dart';
import 'ViewModel/new_app_charge_controller.dart';
import 'ViewModel/otp_screeen_controllert.dart';
import 'ViewModel/register_viewmodel.dart';
import 'ViewModel/schedule_viewmodel.dart';
import 'package:get_storage/get_storage.dart';

import 'ViewModel/send_money_viewmodel.dart';
import 'common/bottom_controller.dart';
import 'model/services/app_notification.dart';

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  ///firebase initiallize

  FirebaseMessaging.onBackgroundMessage(
      AppNotificationHandler.firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  IOSInitializationSettings initializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true);

  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AppNotificationHandler.channel);
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(alert: true, badge: true, sound: true);
  AppNotificationHandler.getInitialMsg();
  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
  AppNotificationHandler.showMsgHandler();
  await AppNotificationHandler.getFcmToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
              initialBinding: BaseBindings(),
              title: 'Plus',

              debugShowCheckedModeBanner: false,
              // home: NewChatScreen1(),
              home: SplashScreen(),
            ));
  }

  BottomController _bottomController = Get.put(BottomController());
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterViewModel(), fenix: true);
    Get.lazyPut(() => CountryPickViewModel(), fenix: true);
    Get.lazyPut(() => ScheduleViewModel(), fenix: true);
    Get.lazyPut(() => AppChargeViewModel(), fenix: true);
    Get.lazyPut(() => ChargeListViewModel(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => BottomController(), fenix: true);
    Get.lazyPut(() => VoiceCallScreenController(), fenix: true);
    Get.lazyPut(() => AppProfileController(), fenix: true);
    Get.lazyPut(() => NewAppChargeController(), fenix: true);
    Get.lazyPut(() => OtpScreenController(), fenix: true);
    Get.lazyPut(() => CountryPickChangeMobileViewModel(), fenix: true);
    Get.lazyPut(() => GetWalletIdViewModel(), fenix: true);
    Get.lazyPut(() => GetAddressIdTraViewModel(), fenix: true);
    Get.lazyPut(() => CreateWalletViewModel(), fenix: true);
    Get.lazyPut(() => GetBalanceViewModel(), fenix: true);
    Get.lazyPut(() => SendMoneyViewModel(), fenix: true);
  }
}
