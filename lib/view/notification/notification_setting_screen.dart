import 'package:consultancy/common/common_drawer.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  _NotificationSettingScreenState createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPicker.themBlackColor,
      drawer: CommonDrawer.commonDrawer(context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Stack(
                        children: [
                          Container(
                            child: PreferenceManager.getImage() == null ||
                                    PreferenceManager.getImage() == ''
                                ? SizedBox()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(
                                      PreferenceManager.getImage(),
                                      fit: BoxFit.cover,
                                    )),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            height: 34.sp,
                            width: 34.sp,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 12.sp,
                              width: 12.sp,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorPicker.whiteColor, width: 2),
                                  shape: BoxShape.circle,
                                  color: ColorPicker.greenIndicatorColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(width: Get.width * 0.15),
                    Text(
                      "NOTIFICATION",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14.sp),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/svg/setting_iocn_d.svg"),
                  ],
                ),
              ),
            ),
            CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
            Container(
              height: Get.height * 0.6,
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(2, (index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.textSemiBoldDynamicP(
                                  text: '11:52',
                                  fontSize: 12.sp,
                                  textColor: ColorPicker.whiteColor),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * 0.02),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/svg/call_bottom_icon.svg"),
                                  CommonSizeBox.commonSizeBox(
                                      width: Get.width * 0.05),
                                  CommonText.textMediumDynamicColorP(
                                      text: "New Call Scheduled by Paula",
                                      textColor: ColorPicker.whiteColor,
                                      textSize: 12.sp),
                                  CommonSizeBox.commonSizeBox(
                                      height: Get.height * 0.01),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 10),
                                child: Container(
                                  height: Get.height * 0.18,
                                  width: Get.width * 0.81,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 0.5, color: Colors.white)),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonSizeBox.commonSizeBox(
                                          height: Get.height * 0.01),
                                      Row(
                                        children: [
                                          CommonSizeBox.commonSizeBox(
                                              width: Get.width * 0.025),
                                          SvgPicture.asset(
                                              "assets/svg/user_blank.svg"),
                                          CommonSizeBox.commonSizeBox(
                                              width: Get.width * 0.03),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText.textBold700PDynamicP(
                                                  text: "Paula Johnson",
                                                  textColor:
                                                      ColorPicker.whiteColor),
                                              CommonSizeBox.commonSizeBox(
                                                  height: Get.height * 0.01),
                                              SvgPicture.asset(
                                                  "assets/svg/paulaButton.svg"),
                                              CommonText.textMediumDynamicColorP(
                                                  text: "15mins Scheduled for",
                                                  // "15mins Scheduled for 19 Wed, March 2022",
                                                  textSize: 8.sp,
                                                  textColor: ColorPicker.whiteColor)
                                            ],
                                          )
                                        ],
                                      ),
                                      CommonSizeBox.commonSizeBox(
                                          height: Get.height * 0.015),
                                      Row(
                                        children: [
                                          CommonSizeBox.commonSizeBox(
                                              width: Get.width * 0.015),

                                          ///====Accept Button======///
                                          GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                  "assets/svg/accep_bt.svg")),
                                          CommonSizeBox.commonSizeBox(
                                              width: Get.width * 0.015),

                                          ///====Reject Button======///
                                          GestureDetector(
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                  "assets/svg/reject_b.svg")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CommonSizeBox.commonSizeBox(height: Get.height * 0.015),
                        Divider(
                          thickness: 0.5.sp,
                          color: Color(0xffA3A3A3),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
            Divider(
              thickness: 0.5.sp,
              color: Color(0xffA3A3A3),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/call_bottom_icon.svg"),
                  CommonSizeBox.commonSizeBox(width: Get.width * 0.05),
                  CommonText.textMediumDynamicColorP(
                      text: "You Scheduled a Call with Laura Lauryl",
                      textColor: ColorPicker.whiteColor,
                      textSize: 12.sp),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.01),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65, top: 10, right: 20),
              child: Container(
                width: Get.width,
                height: Get.height * 0.1,
                decoration: BoxDecoration(
                    color: Color(0xff777794),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textMediumDynamicColorP(
                          text: "Laura Lauryl",
                          textColor: ColorPicker.whiteColor,
                          textSize: 12.sp),
                      CommonSizeBox.commonSizeBox(height: Get.height * 0.008),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svg/james_button.svg"),
                          CommonSizeBox.commonSizeBox(width: Get.width * 0.015),
                          CommonText.textSemiBoldDynamicP(
                              text: "\$0.40 Per minute",
                              textColor: ColorPicker.whiteColor)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            CommonSizeBox.commonSizeBox(height: Get.height * 0.015),
            Divider(
              thickness: 0.5.sp,
              color: Color(0xffA3A3A3),
            ),
          ],
        ),
      ),
    );
  }
}
