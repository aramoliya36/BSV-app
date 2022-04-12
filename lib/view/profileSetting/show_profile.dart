import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ShowProfileApp extends StatefulWidget {
  const ShowProfileApp({Key? key}) : super(key: key);

  @override
  _ShowProfileAppState createState() => _ShowProfileAppState();
}

class _ShowProfileAppState extends State<ShowProfileApp> {
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorPicker.themBlackColor,
        appBar: CommonWidget.appBarWithTitleBottom(
            title: 'Edit Profile',
            function: () {
              _bottomController.bottomIndex.value = 2;
              _bottomController.selectedScreen('UserHomeWidget');
            }),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('UserAllData')
                .doc(PreferenceManager.getTokenId())
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var _res = snapshot.data;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 80.sp,
                              width: 80.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.network(
                                    _res['userImage'],
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 104.sp,
                              child: Container(
                                height: 30.sp,
                                child: Image.asset(
                                  'assets/images/pan_icon.png',
                                ),
                              ))
                        ],
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Align(
                        alignment: Alignment.center,
                        child: CommonText.textMediumDynamicColorP(
                          text: _res['user_name'] ?? '',
                          textColor: ColorPicker.whiteColor,
                          textSize: 15.sp,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CommonText.textLightDynamicW300(
                          text: _res['name'] ?? "",
                          textColor: ColorPicker.hintTextColor,
                          textSize: 10.sp,
                        ),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PreferenceManager.getLoginType() == 'mobile'
                                ? CommonText.textMediumDynamicColorP(
                                    text: 'Phone',
                                    textColor: ColorPicker.whiteColor,
                                    textSize: 13.sp)
                                : SizedBox(),
                            PreferenceManager.getLoginType() == 'mobile'
                                ? CommonText.textLightDynamicW300(
                                    text:
                                        PreferenceManager.getLoginValue() ?? '',
                                    textColor: ColorPicker.hintTextColor,
                                    textSize: 10.sp)
                                : SizedBox(),
                          ],
                        ),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PreferenceManager.getLoginType() == 'email' ||
                                    PreferenceManager.getLoginType() == 'google'
                                ? CommonText.textMediumDynamicColorP(
                                    text: 'Email',
                                    textColor: ColorPicker.whiteColor,
                                    textSize: 13.sp)
                                : SizedBox(),
                            PreferenceManager.getLoginType() == 'email' ||
                                    PreferenceManager.getLoginType() == 'google'
                                ? CommonText.textLightDynamicW300(
                                    text:
                                        PreferenceManager.getLoginValue() ?? '',
                                    textColor: ColorPicker.hintTextColor,
                                    textSize: 10.sp)
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textMediumDynamicColorP(
                                text: 'About  ',
                                textColor: ColorPicker.whiteColor,
                                textSize: 13.sp),
                            CommonText.textLightDynamicW300(
                                text: _res['tell_us_about'] ?? '',
                                textColor: ColorPicker.hintTextColor,
                                textSize: 10.sp),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.textMediumDynamicColorP(
                                    text: 'Profile Link',
                                    textColor: ColorPicker.whiteColor,
                                    textSize: 13.sp),
                                CommonText.textLightDynamicW300(
                                    text: 'https://www.plus-app/johnson',
                                    textColor: ColorPicker.hintTextColor,
                                    textSize: 10.sp),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: CommonText.textMediumDynamicColorP(
                                  text: 'Copy Link',
                                  textColor: Color(0xff2DDB87),
                                  textSize: 10.sp),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return circularProgress();
              }
            },
          ),
        ),
      ),
      onWillPop: () {
        _bottomController.bottomIndex.value = 2;
        _bottomController.selectedScreen('UserHomeWidget');
        return Future.value(false);
      },
    );
  }
}
