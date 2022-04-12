import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/model/services/google_sign_in.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  BottomController _bottomController = Get.find();
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _bottomController.bottomIndex.value = 3;
        _bottomController.setSelectedScreen('AccountScreen');
        return Future.value(false);
      },
      child: Material(
        color: ColorPicker.themBlackColor,
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('UserAllData')
              .doc(PreferenceManager.getTokenId())
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var _res = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                      child: CommonWidget.appBarWithTitleBottom(
                          function: () {
                            _bottomController.bottomIndex.value = 3;
                            _bottomController
                                .setSelectedScreen('AccountScreen');
                          },
                          title: "Account Information")),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.025,
                        ),

                        ///=========Name==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "Name",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: _res['name'] ?? '',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========+Handle==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "+Handle",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: _res['user_name'] ?? '',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Phone==========///

                        PreferenceManager.getLoginType() == 'mobile'
                            ? CommonText.textSemiBoldDynamicP(
                                text: "Phone",
                                textColor: ColorPicker.whiteColor,
                                fontSize: 12.sp)
                            : SizedBox(),
                        PreferenceManager.getLoginType() == 'mobile'
                            ? CommonText.textMediumDynamicColorP(
                                text: PreferenceManager.getLoginValue() ?? '',
                                textColor: ColorPicker.hintTextColor,
                                textSize: 10.sp)
                            : SizedBox(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Email==========///

                        PreferenceManager.getLoginType() == 'google' ||
                                PreferenceManager.getLoginType() == 'email'
                            ? CommonText.textSemiBoldDynamicP(
                                text: "Email",
                                textColor: ColorPicker.whiteColor,
                                fontSize: 12.sp)
                            : SizedBox(),
                        PreferenceManager.getLoginType() == 'google' ||
                                PreferenceManager.getLoginType() == 'email'
                            ? CommonText.textMediumDynamicColorP(
                                text: PreferenceManager.getLoginValue() ?? '',
                                textColor: ColorPicker.hintTextColor,
                                textSize: 10.sp)
                            : SizedBox(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Country==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "Country ",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: 'United Kingdom',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Website==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "Website ",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: 'www.',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Occupation==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "Occupation ",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: 'Artist',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========About==========///

                        CommonText.textSemiBoldDynamicP(
                            text: "About ",
                            textColor: ColorPicker.whiteColor,
                            fontSize: 12.sp),
                        CommonText.textMediumDynamicColorP(
                            text: 'Hello.......',
                            textColor: ColorPicker.hintTextColor,
                            textSize: 10.sp),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        ///=========Log Out==========///

                        InkWell(
                          onTap: () {
                            if (PreferenceManager.getLoginType() == 'google') {
                              SignInWithGoogle().signOutGoogle();
                            }
                            _signOut();

                            PreferenceManager.getStorage.erase();
                            _bottomController.bottomIndex.value = 3;
                            _bottomController.selectedScreen('UserHomeWidget');
                            Get.offAll(SplashScreen());
                          },
                          child: CommonText.textSemiBoldDynamicP(
                              text: "Log Out ",
                              textColor: Color(0xffE32525),
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return circularProgress();
            }
          },
        ),
      ),
    );
  }
}
