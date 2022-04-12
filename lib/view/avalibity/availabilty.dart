import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AvailabiltyScreen extends StatefulWidget {
  const AvailabiltyScreen({Key? key}) : super(key: key);

  @override
  _AvailabiltyScreenState createState() => _AvailabiltyScreenState();
}

class _AvailabiltyScreenState extends State<AvailabiltyScreen> {
  List<String>? hobbies;
  bool brandCheckBox = false;
  BottomController _bottomController = Get.find();

  ///====== CheckBox=========///
  List<String> listCheckBox = [];
  void addTocheckBox(String value) {
    if (listCheckBox.contains(value)) {
      listCheckBox.remove(value);
    } else {
      listCheckBox.add(value);
    }
    hobbies = listCheckBox;
  }

  List<String> brandList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> minIndex = ['15', "30", "60", "90", "120"];
  int changeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorPicker.themBlackColor,
        appBar: CommonWidget.appBarWithTitleBottom(
            title: "Availabilty",
            function: () {
              _bottomController.selectedScreen('AppSettings');
              _bottomController.bottomIndex.value = 3;
            }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonSizeBox.commonSizeBox(height: 5.sp),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/info_icon.svg"),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Text(
                      "Define at which time your guests can book \na meeting with you",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorPicker.hintTextColor,
                          fontSize: 12.sp),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CommonText.textSemiBoldDynamicP(
                  fontSize: 12.sp,
                  textColor: ColorPicker.whiteColor,
                  text: "Set your weekdays availabilty",
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "Europe/London",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorPicker.hintTextColor,
                      fontSize: 12.sp),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    brandList.length,
                    (index) {
                      return Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              addTocheckBox(brandList[index]);
                              setState(() {
                                brandCheckBox = value!;
                              });
                            },
                            value: listCheckBox.contains(brandList[index])
                                ? true
                                : false,
                            focusColor: Colors.white,
                            activeColor: Color(0xff777794),
                            hoverColor: Colors.grey,
                          ),

                          /// =======Brand text====///
                          Container(
                            height: Get.height * 0.03,
                            width: Get.width * 0.25,
                            // color: Colors.yellow,
                            child: CommonText.textMediumDynamicColorP(
                                textColor: ColorPicker.whiteColor,
                                textSize: 10.sp,
                                text: "${brandList[index]}"),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),

                          /// ======1st=Container====///
                          Container(
                            height: Get.height * 0.035,
                            width: Get.width * 0.18,
                            decoration: BoxDecoration(
                                // color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorPicker.whiteColor)),
                            child: Center(
                                child: CommonText.textRegularWhiteW400(
                                    text: "8:00")),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),

                          /// ======text(to)====///
                          Container(
                            height: Get.height * 0.03,
                            width: Get.width * 0.05,
                            // color: Colors.green,
                            child: CommonText.textMediumDynamicColorP(
                                textColor: ColorPicker.whiteColor,
                                textSize: 12.sp,
                                text: "to"),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),

                          /// ======2nd=Container====///
                          Container(
                            height: Get.height * 0.035,
                            width: Get.width * 0.18,
                            decoration: BoxDecoration(

                                // color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorPicker.whiteColor)),
                            child: Center(
                                child: CommonText.textRegularWhiteW400(
                                    text: "18:00")),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CommonText.textSemiBoldDynamicP(
                  fontSize: 12.sp,
                  textColor: ColorPicker.whiteColor,
                  text: "Like to Set a break time?",
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/add_breack.svg"),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Text(
                      "Add Break",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorPicker.whiteColor,
                          fontSize: 12.sp),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                CommonText.textSemiBoldDynamicP(
                  fontSize: 12.sp,
                  textColor: ColorPicker.whiteColor,
                  text: "Meeting duration",
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                    children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        changeIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.16,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              CommonText.textMediumDynamicColorP(
                                  text: "${minIndex[index]}",
                                  textColor: Colors.white,
                                  textSize: 10.sp),
                              CommonText.textMediumDynamicColorP(
                                  text: "mins",
                                  textColor: Colors.white,
                                  textSize: 10.sp),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: changeIndex == index
                                ? ColorPicker.buttonColor
                                : ColorPicker.themBlackColor,
                            border: Border.all(color: Colors.white),
                            // color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  );
                })),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                CommonButton.commonSignButtonWithoutIcon(
                    name: "APPLY", onTap: () {}),
                SizedBox(
                  height: Get.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        //  Get.back();
        _bottomController.selectedScreen('AppSettings');
        _bottomController.bottomIndex.value = 3;
        return Future.value(false);
      },
    );
  }
}
