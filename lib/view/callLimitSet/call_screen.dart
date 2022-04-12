import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  var addRemove = 0;
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorPicker.themBlackColor,
          appBar: CommonWidget.appBarWithTitleBottom(
              title: 'Calls',
              function: () {
                _bottomController.bottomIndex.value = 3;
                _bottomController.selectedScreen('AppSettings');
              }),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textSemiBoldDynamicP(
                        text: "Call Limit",
                        textColor: ColorPicker.whiteColor,
                        fontSize: 12.sp),
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
                CommonText.textRegularW400(
                  text: "Set your call limit",
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CommonText.textSemiBoldDynamicP(
                    text: "Voice Calls",
                    textColor: ColorPicker.whiteColor,
                    fontSize: 12.sp),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                voiceCallRow(
                    title: "Set Call Limit",
                    iconss: "assets/svg/timer.svg",
                    addTitle: " $addRemove min",
                    addFunction: () {
                      addRemove++;
                    },
                    addSvg: "assets/svg/incre.svg",
                    removeFunction: () {
                      addRemove--;
                    },
                    removeSvg: "assets/svg/substract.svg"),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                CommonText.textSemiBoldDynamicP(
                    text: "Video Calls",
                    textColor: ColorPicker.whiteColor,
                    fontSize: 12.sp),
                SizedBox(
                  height: Get.height * 0.010,
                ),
                voiceCallRow(
                    title: "Set Call Limit",
                    iconss: "assets/svg/timer.svg",
                    addTitle: " $addRemove min",
                    addFunction: () {
                      setState(() {
                        addRemove++;
                      });
                    },
                    addSvg: "assets/svg/incre.svg",
                    removeFunction: () {
                      setState(() {
                        addRemove--;
                      });
                    },
                    removeSvg: "assets/svg/substract.svg"),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textMediumDynamicColorP(
                        text: "Enable Start of Call Free Minutes",
                        textColor: ColorPicker.whiteColor,
                        textSize: 10.sp),
                    Switch(
                      activeColor: Colors.green,
                      value: isSwitched1,
                      onChanged: (value) {
                        setState(() {
                          isSwitched1 = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textMediumDynamicColorP(
                        text: "Display Unavailable, Schedule a call",
                        textColor: ColorPicker.whiteColor,
                        textSize: 10.sp),
                    Switch(
                      activeColor: Colors.green,
                      value: isSwitched2,
                      onChanged: (value) {
                        setState(() {
                          isSwitched2 = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CommonText.textSemiBoldDynamicP(
                    text: "Scheduling Option",
                    textColor: ColorPicker.whiteColor,
                    fontSize: 12.sp),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 18.sp,
                        child: SvgPicture.asset("assets/svg/calender.svg")),
                    CommonText.textMediumDynamicColorP(
                        text: "Set  Availability",
                        textColor: ColorPicker.hintTextColor,
                        textSize: 10.sp),
                    SizedBox(
                      width: Get.width * 0.35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('AppSettings');
          return Future.value(false);
        });
  }

  Widget voiceCallRow({
    String? title,
    String? addTitle,
    String? iconss,
    dynamic removeFunction,
    dynamic addFunction,
    String? removeSvg,
    String? addSvg,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(iconss!),
        CommonText.textMediumDynamicColorP(
            text: title!, textColor: ColorPicker.whiteColor, textSize: 10.sp),
        SizedBox(
          width: Get.width * 0.2,
        ),
        Container(
          height: Get.height * 0.052,
          width: Get.width * 0.35,
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: removeFunction,
                child: CommonWidget.svgPicture(
                  image: removeSvg!,
                ),
              ),
              CommonText.textSemiBoldDynamicP(
                  text: addTitle!,
                  textColor: ColorPicker.whiteColor,
                  fontSize: 12.sp),
              GestureDetector(
                onTap: addFunction,
                child: CommonWidget.svgPicture(
                  image: addSvg!,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
