import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool isSwitched = false;
  var addRemove = 0;
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SingleChildScrollView(
          child: Material(
            color: ColorPicker.themBlackColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(
                    child: CommonWidget.appBarWithTitleBottom(
                        title: "Privacy",
                        function: () {
                          _bottomController.selectedScreen('AccountScreen');
                          _bottomController.bottomIndex.value = 3;
                        })),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      buildRowGestureDetector(
                          onTap: () {}, title: "Profile Photo"),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      buildRowGestureDetector(onTap: () {}, title: "Last Seen"),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      buildRowGestureDetector(onTap: () {}, title: "About"),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      buildRowGestureDetector(onTap: () {}, title: "Groups"),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      buildRowGestureDetector(
                          onTap: () {}, title: "Live Location"),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      CommonText.textMediumDynamicColor400(
                          text:
                              "List of Chats where you are sharing your live location",
                          textColor: ColorPicker.hintTextColor,
                          textSize: 8.sp),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      buildRowGestureDetector(onTap: () {}, title: "Groups"),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      CommonText.textMediumDynamicColor400(
                          text: "List of Numbers blocked",
                          textColor: ColorPicker.hintTextColor,
                          textSize: 8.sp),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.textSemiBoldDynamicP(
                            text: "Read Receipt",
                            textColor: ColorPicker.whiteColor,
                          ),
                          Switch(
                            activeColor: Colors.green,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.12,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CommonText.textSemiBoldDynamicP(
                          text: "Privacy Center",
                          textColor: ColorPicker.whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CommonText.textSemiBoldDynamicP(
                          text: "Privacy Policy",
                          textColor: ColorPicker.whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CommonText.textSemiBoldDynamicP(
                          text: "Contact us",
                          textColor: ColorPicker.whiteColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () {
          _bottomController.selectedScreen('AccountScreen');
          _bottomController.bottomIndex.value = 3;
          return Future.value(false);
        });
  }

  Widget buildRowGestureDetector({dynamic onTap, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText.textSemiBoldDynamicP(
            text: title!,
            textColor: ColorPicker.whiteColor,
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 12.sp,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
