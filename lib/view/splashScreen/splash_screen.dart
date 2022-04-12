import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/view/auths/email_sign_screen.dart';
import 'package:consultancy/view/auths/register_screen.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/by_default_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  bool? exist;
  var isStatusData;
  Future<bool?> checkExist() async {
    try {
      await FirebaseFirestore.instance
          .collection("UserAllData")
          .doc(PreferenceManager.getTokenId())
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      print('-----------exist--- $exist');
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  navigatorScreen() async {
    await checkExist();
    print('---------exist $exist');
    if (exist == true) {
      var collection = FirebaseFirestore.instance
          .collection('UserAllData')
          .doc(PreferenceManager.getTokenId());
      var querySnapshot = await collection.get();
      print('--------name--------2${querySnapshot['name']}');
      if (querySnapshot['profileDetails'] == true) {
        PreferenceManager.setNotSearchHandel(querySnapshot['user_name']);

        PreferenceManager.setFnameId(querySnapshot['name']);
        PreferenceManager.setImage(querySnapshot['userImage']);
        FirebaseFirestore.instance
            .collection('UserAllData')
            .doc(querySnapshot['auth_Token'])
            .update({'fcm_token': PreferenceManager.getFcmToken()});
        if (querySnapshot['isCharges'] == false) {
          Get.offAll(AppCharges());
        } else {
          Get.offAll(NavigationBarScreen());
        }
      } else {
        Get.offAll(ByDefaultScreen());
      }
    } else {
      Get.offAll(ByDefaultScreen());
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 2), () {
      if (PreferenceManager.getTokenId() != null) {
        navigatorScreen();
      } else {
        Get.offAll(EmailSignScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        'assets/svg/app_splash.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
