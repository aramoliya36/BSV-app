import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/services/google_sign_in.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'bottom_controller.dart';
import 'common_widget.dart';

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

Widget buildDrawerContainer({String? title, dynamic onTap, String? svgImage}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        SizedBox(
            width: 18.sp,
            height: 30.sp,
            child: CommonWidget.svgPicture(image: svgImage!)),
        CommonSizeBox.commonSizeBox(width: Get.width * 0.04),
        CommonText.textMediumDynamicColorP(
            text: title!, textColor: ColorPicker.whiteColor)
      ],
    ),
  );
}

BottomController _bottomController = Get.find();

class CommonDrawer {
  static Container commonDrawer({required BuildContext context}) {
    return Container(
      height: Get.height,
      color: ColorPicker.themBlackColor,
      width: 200,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.08,
                      width: Get.width * 0.16,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: PreferenceManager.getImage() == null ||
                                  PreferenceManager.getImage() == ''
                              ? SizedBox()
                              : Image.network(
                                  PreferenceManager.getImage(),
                                  fit: BoxFit.cover,
                                )),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(45)),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: ColorPicker.whiteColor,
                        ))
                  ],
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.01),
                CommonText.textSemiBoldDynamicP(
                    text: PreferenceManager.getFnameId() ?? '',
                    textColor: ColorPicker.whiteColor),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: Get.height * 0.04,
                    // width: Get.width * 0.2,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: CommonText.textMediumDynamicColorP(
                          text: PreferenceManager.getNotSearchHandel() ?? '',
                          textColor: ColorPicker.whiteColor),
                    ),

                    decoration: BoxDecoration(
                        color: ColorPicker.greenButtonColor,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                buildDrawerContainer(
                    title: "Profile",
                    onTap: () {
                      Get.back();
                      _bottomController.selectedScreen('ShowProfileApp');
                      _bottomController.bottomIndex.value = 2;
                      // Get.to(EditProfileApp());
                    },
                    svgImage: "assets/svg/person_profile_icon.svg"),
                buildDrawerContainer(
                    title: "Calender",
                    onTap: () {},
                    svgImage: "assets/svg/calender_icon.svg"),
                buildDrawerContainer(
                    title: "Wallet",
                    onTap: () {
                      _bottomController.selectedScreen('BitCoinScreen');
                      _bottomController.bottomIndex.value = 2;
                    },
                    svgImage: "assets/svg/wallet.svg"),
                CommonSizeBox.commonSizeBox(height: 160.sp),
                buildDrawerContainer(
                    title: "Get Help",
                    onTap: () {},
                    svgImage: "assets/svg/qu_mark.svg"),
                buildDrawerContainer(
                    title: "Settings",
                    onTap: () {
                      Get.back();

                      _bottomController.selectedScreen('AppSettings');
                      _bottomController.bottomIndex.value = 3;
                    },
                    svgImage: "assets/svg/setting_iocn_d.svg"),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        // homeController.selectedScreen.value = 'HomeScreen';
                                        //Get.to(SignInScreen());
                                      },
                                      color: ColorPicker.themBlackColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                      child: Text(
                                        'Log out',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Get.back();

                                        if (PreferenceManager.getLoginType() ==
                                            'google') {
                                          SignInWithGoogle().signOutGoogle();
                                        }
                                        _signOut();

                                        PreferenceManager.getStorage.erase();
                                        _bottomController.bottomIndex.value = 3;
                                        _bottomController
                                            .selectedScreen('UserHomeWidget');
                                        Get.offAll(SplashScreen());
                                      },
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )
                            ],
                          );
                        });

                    ///
                    // if (PreferenceManager.getLoginType() == 'google') {
                    //   SignInWithGoogle().signOutGoogle();
                    // }
                    // _signOut();
                    //
                    // PreferenceManager.getStorage.erase();
                    // _bottomController.bottomIndex.value = 3;
                    // _bottomController.selectedScreen('UserHomeWidget');
                    // Get.offAll(SplashScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.sp),
                    child: CommonText.textBold700PDynamicP(
                        text: 'Log out', textColor: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
