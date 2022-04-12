// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:consultancy/ViewModel/calling_screen_controller.dart';
// import 'package:consultancy/common/bottom_controller.dart';
// import 'package:consultancy/common/common_widget.dart';
// import 'package:consultancy/common/preference_manager.dart';
// import 'package:consultancy/common/size_box.dart';
// import 'package:consultancy/res/Colors/colors_class.dart';
// import 'package:consultancy/res/text/text_common.dart';
// import 'package:consultancy/view/bottombar/widget/calender_tab_screen.dart';
// import 'package:consultancy/view/bottombar/widget/calls_tab_screen.dart';
// import 'package:consultancy/view/bottombar/widget/chat_tab_screen.dart';
// import 'package:consultancy/view/bottombar/widget/notifications_tab_screen.dart';
// import 'package:consultancy/view/bottombar/widget/wallet_tab_screen.dart';
// import 'package:consultancy/view/call/profile_Screen_page.dart';
// import 'package:consultancy/view/callHistory/recent_call_Screen.dart';
// import 'package:consultancy/view/charges/app_charges.dart';
// import 'package:consultancy/view/homeScreen/user_home_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:consultancy/view/wallet/buy_bitcoin.dart';
// import 'dart:io' show Platform;
//
// class NavigationBarScreen extends StatefulWidget {
//   @override
//   _NavigationBarScreenState createState() => _NavigationBarScreenState();
// }
//
// class _NavigationBarScreenState extends State<NavigationBarScreen> {
//   BottomController bottomController = Get.find();
//   VoiceCallScreenController _voiceCallScreenController = Get.find();
//
//   List<Widget> tabPages = [
//     UserHomeWidget(),
//     RecentCallScreen(),
//     BitCoinScreen(),
//     UserHomeWidget(),
//     RecentCallScreen()
//   ];
//   List<Map<String, String>> bottomBarData = [
//     {
//       "title": "Calls",
//       "Icon": "assets/svg/call_bottom_icon.svg",
//     },
//     {
//       "title": "Calender",
//       "Icon": "assets/svg/calender_bottom_icon.svg",
//     },
//     {
//       "title": "Wallet",
//       "Icon": "assets/svg/wallet.svg",
//     },
//     {
//       "title": "Chats",
//       "Icon": "assets/svg/chat_bottom_icon.svg",
//     },
//     {
//       "title": "Notifications",
//       "Icon": "assets/svg/notification_bottom.svg",
//     },
//   ];
//   bool isCall = false;
//   isBottom() {
//     bottomController.bottomIndex.value = 3;
//     bottomController.setSelectedScreen('UserHomeWidget');
//   }
//
//   @override
//   void initState() {
//     // isBottom();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection('UserAllData')
//           .doc(PreferenceManager.getTokenId())
//           .snapshots(),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data['isCalling'] == true) {
//             _voiceCallScreenController.callerName =
//             snapshot.data['caller_name'];
//             _voiceCallScreenController.channelId =
//             snapshot.data['agora_channel_name'];
//             _voiceCallScreenController.tokenID = snapshot.data['agora_token'];
//             _voiceCallScreenController.setCallerAuthToken(
//                 callerAuthTokenValue: snapshot.data['caller_auth_token']);
//             _voiceCallScreenController.setTrueVideo(
//                 isVideoCall: snapshot.data['isVideoCall']);
//
//           }
//           bottomController.isCallCutter.value = snapshot.data['isCalling'];
//
//           if (snapshot.data['isCalling'] == false) {
//             FlutterRingtonePlayer.stop();
//           }
//         }
//         return Obx(() => (bottomController.isCallCutter.value == true &&
//             bottomController.isRingtone.value == false)
//             ? ProfileScreenPage()
//             : Scaffold(
//           backgroundColor: ColorPicker.themBlackColor,
//           bottomNavigationBar:
//           bottomController.selectedScreen.value == 'ChatRoom'
//               ? SizedBox()
//               : bottomNavigationBar(),
//           body: bottomController.selectedScreen.value != ''
//               ? bottomController.bottomIndex.value == 0
//               ? callTabScreen()
//               : bottomController.bottomIndex.value == 1
//               ? calenderScreen()
//               : bottomController.bottomIndex.value == 2
//               ? walletScreen()
//               : bottomController.bottomIndex.value == 3
//               ? chatTabScreen()
//               : bottomController.bottomIndex.value == 4
//               ? notificationTabScreen()
//               : chatTabScreen()
//               : tabPages[bottomController.bottomIndex.value],
//         ));
//       },
//     );
//   }
//
//   Widget bottomNavigationBar() {
//     return Container(
//       height: Platform.isIOS ? Get.height * 0.095 : Get.height * 0.07,
//       width: Get.width,
//       color: Colors.transparent,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: bottomBarData
//             .map((e) => InkResponse(
//           onTap: () {
//             onTabTapped(bottomBarData.indexOf(e));
//           },
//           child: Padding(
//             padding:
//             EdgeInsets.symmetric(vertical: Platform.isIOS ? 15 : 5),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                     child: SvgPicture.asset(
//                       e["Icon"]!,
//                       color: bottomController.bottomIndex.value ==
//                           bottomBarData.indexOf(e)
//                           ? ColorPicker.whiteColor
//                           : Colors.grey,
//                     )),
//                 SizedBox(
//                   height: 2,
//                 ),
//                 Text(
//                   e["title"]!,
//                   style: TextStyle(
//                       color: bottomController.bottomIndex.value ==
//                           bottomBarData.indexOf(e)
//                           ? ColorPicker.whiteColor
//                           : Colors.grey,
//                       fontSize: Get.height * 0.02),
//                 ),
//               ],
//             ),
//           ),
//         ))
//             .toList(),
//       ),
//     );
//   }
//
//   void onTabTapped(int index) {
//     bottomController.bottomIndex.value = index;
//     print('========--- ${bottomController.bottomIndex.value}');
//     if (index == 0) {
//       bottomController.selectedScreen('RecentCallScreen');
//     }
//     if (index == 1) {
//       bottomController.selectedScreen('SedualCalander');
//     }
//     if (index == 2) {
//       bottomController.selectedScreen('BitCoinScreen');
//     }
//     if (index == 3) {
//       bottomController.selectedScreen('UserHomeWidget');
//     }
//     if (index == 4) {
//       bottomController.selectedScreen('NotificationSettingScreen');
//     }
//   }
// }
