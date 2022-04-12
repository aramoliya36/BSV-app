import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:consultancy/model/services/firebase_auth.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/by_default_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EmailEndVerifyContinue extends StatefulWidget {
  final String email;
  final String password;
  const EmailEndVerifyContinue(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _EmailEndVerifyContinueState createState() => _EmailEndVerifyContinueState();
}

class _EmailEndVerifyContinueState extends State<EmailEndVerifyContinue> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  RegisterRelasiyaReqModel _registerRelasiyaReqModel =
      RegisterRelasiyaReqModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ProgressHUD(
          child: Builder(
            builder: (context) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      'assets/svg/back_icon.svg',
                    ),
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height / 24),
                  Center(child: SvgPicture.asset('assets/svg/app_icon.svg')),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.18),
                  CommonButton.commonButtonWithoutIcon(
                      name: "Log into email and verify to continue",
                      onTap: () async {
                        final progress = ProgressHUD.of(context);
                        progress?.show();
                        try {
                          await kFirebaseAuth.createUserWithEmailAndPassword(
                              email: widget.email, password: widget.password);
                          String uid = _auth.currentUser!.uid.toString();
                          print('---------uid in current user $uid');
                          PreferenceManager.setTokenId(uid);
                          PreferenceManager.setLoginValue(widget.email);

                          print(
                              '---------uid in current user token id ${PreferenceManager.getTokenId()}');
                          //
                          //                       // Future.delayed(Duration(seconds: 2), () {
                          PreferenceManager.setLoginType('email');

                          navigatorScreen(progress: progress);
                          progress?.dismiss();
                        } catch (e) {
                          progress?.dismiss();

                          return CommonSnackBar.showSnackBar(
                              successStatus: false, msg: '$e');
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool? exist;

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

  navigatorScreen({final progress}) async {
    // await checkExist();

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
        progress?.dismiss();

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
}
