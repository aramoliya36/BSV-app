import 'dart:convert';
import 'dart:developer';
import 'package:consultancy/common/preference_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:http/http.dart' as http;

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  ///get fcm token
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken();

      await PreferenceManager.setFcmToken(token!);
      print('--------get fcm pref ${PreferenceManager.getFcmToken()}');
      // log("=========fcm-token===$token");
      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
      return null;
    }
  }

  ///call when app in fore ground
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      print(
          'NOtification Call :${notification?.apple}${notification!.body}${notification.title}${notification.bodyLocKey}${notification.bodyLocKey}');
      FlutterRingtonePlayer.stop();

      if (message != null) {
        print(
            "action==onMessage.listen====1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        showMsg(notification);
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('------RemoteMessage message------$message');
      if (message != null) {
        //  FlutterRingtonePlayer.stop();

        print("action======1=== ${message.data['action_click']}");
        print("slug======2=== ${message.data['slug_name']}");
        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              //'This channel is used for important notifications.',
              // description
              importance: Importance.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: IOSNotificationDetails()));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    RemoteNotification? notification = message.notification;
    print(
        '--------split body ${notification!.body.toString().split(' ').first}');
    if (notification.body.toString().split(' ').first == 'calling') {
      print('----in this app');
      // FlutterRingtonePlayer.playRingtone(
      //     looping: false, volume: 50, asAlarm: false);
    }

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('listen->${message.data}');
      FlutterRingtonePlayer.stop();

      if (message != null) {
        // print("action======1=== ${message?.data['action_click']}");
        print("action======2=== ${message.data['action_click']}");
        //  FlutterRingtonePlayer.stop();

        // _barViewModel.selectedRoute('DashBoardScreen');
        // _barViewModel.selectedBottomIndex(0);

        // Get.offAll(SplashPage());
      }
    });
  }

  /// send notification device to device
  static Future<bool?> sendMessage(
      {String? receiverFcmToken, String? msg, bool isRing = false}) async {
    var serverKey =
        'AAAAHdl8g4g:APA91bFd4Jtck1AXgYDZSgTKSh7CbS41kSXA5Ht74HN74qXo-_lsSpPJrLhS2GdqcHf2IJEWM3uUKD3-V50gpemU9FDmZZkm2ZYZIVaQ_dZKq4oA9-VJY263y98pksdNdzT9iHrD8cUa';
    try {
      // for (String token in receiverFcmToken) {
      log("RESPONSE TOKEN  $receiverFcmToken");

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg ?? 'msg',
              'title': PreferenceManager.getFnameId().isEmpty
                  ? 'plusApp'
                  : PreferenceManager.getFnameId(),
              'bodyLocKey': 'true'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': isRing,
              'id': '1',
              'status': 'done'
            },
            'to': receiverFcmToken,
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");

      log("RESPONSE BODY ${response.body}");
      // return true}
    } catch (e) {
      print("error push notification");
      // return false;

    }
  }
}
