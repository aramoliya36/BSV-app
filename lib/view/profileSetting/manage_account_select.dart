import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManageAccountSelect extends StatefulWidget {
  const ManageAccountSelect({Key? key}) : super(key: key);

  @override
  _ManageAccountSelectState createState() => _ManageAccountSelectState();
}

class _ManageAccountSelectState extends State<ManageAccountSelect> {
  String? _radioValue;
  String? choice;
  String? gender;
  radioButtonChanges(value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '+JohnsonSilvestre ':
          choice = value;
          break;
        case '+Johnson1234':
          choice = value;
          break;
        case '+Beyonce':
          choice = value;
          break;
        case '+JayZ':
          choice = value;
          break;
        case '+John':
          choice = value;
          break;
        case '+JackD':
          choice = value;
          break;
        default:
          choice = '';
      }
      debugPrint(choice);
      gender = choice;
      //Debug the choice in console
    });
  }

  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: ColorPicker.themBlackColor,
            appBar: CommonWidget.appBarWithTitleBottom(
                title: 'Manage Handles',
                function: () {
                  _bottomController.bottomIndex.value = 3;
                  _bottomController.selectedScreen('AppSettings');
                }),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow(
                        value: "+JohnsonSilvestre ",
                        title: "+JohnsonSilvestre ",
                        onChanged: () {
                          return radioButtonChanges('+JohnsonSilvestre ');
                        }),
                    buildRow(
                        value: "+Johnson1234",
                        title: "+Johnson1234",
                        onChanged: () {
                          return radioButtonChanges('+Johnson1234');
                        }),
                    buildRow(
                        value: "+Beyonce",
                        title: "+Beyonce",
                        onChanged: () {
                          return radioButtonChanges('+Beyonce');
                        }),
                    buildRow(
                        value: "+JayZ ",
                        title: "+JayZ ",
                        onChanged: () {
                          return radioButtonChanges('+JayZ ');
                        }),
                    buildRow(
                        value: "+John ",
                        title: "+John ",
                        onChanged: () {
                          return radioButtonChanges('+John ');
                        }),
                    buildRow(
                        value: "+JackD ",
                        title: "+JackD ",
                        onChanged: () {
                          return radioButtonChanges('+JackD ');
                        }),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Trade +Handles",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: ColorPicker.whiteColor,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(
                      height: Get.height * 0.022,
                    ),
                    CommonText.textMediumDynamicColorP(
                        text: "+JohnsonSilvestre ",
                        textSize: 14.sp,
                        textColor: ColorPicker.hintTextColor)
                  ]),
            )),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('AppSettings');
          return Future.value(false);
        });
  }

  Widget buildRow({String? value, String? title, dynamic onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        children: [
          InkWell(
            onTap: onChanged,
            child: Container(
              height: 15.sp,
              width: 15.sp,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 10.sp,
                  width: 10.sp,
                  decoration: BoxDecoration(
                      color: _radioValue == value ? Colors.black : Colors.white,
                      shape: BoxShape.circle),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
            ),
          ),
          CommonSizeBox.commonSizeBox(width: 16.sp),
          CommonText.textMediumDynamicColorP(
              text: title!, textColor: ColorPicker.whiteColor, textSize: 13.sp),
          Spacer(),
          _radioValue == value
              ? CommonText.textLightDynamicW300(
                  text: 'Primary',
                  textSize: 9.sp,
                  textColor: ColorPicker.hintTextColor)
              : SizedBox()
        ],
      ),
    );
  }
}
