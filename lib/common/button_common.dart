import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:consultancy/Res/Text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CommonButton {
  static commonButton(
      {SvgPicture? iconImage,
      required String name,
      dynamic onTap,
      required bool isTap}) {
    return Container(
      height: Get.height / 16,
      //width: Get.width / 1.4,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorPicker.whiteColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconImage!,
          CommonText.textMediumP(text: name),
          IconButton(
              onPressed: onTap,
              icon: isTap
                  ? Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: ColorPicker.whiteColor,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: ColorPicker.whiteColor,
                    )),
        ],
      ),
    );
  }

  static commonButtonWithoutIcon({required String name, dynamic onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height / 16,
        // width: Get.width / 1.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorPicker.whiteColor)),
        child: CommonText.textMediumP(text: name),
      ),
    );
  }

  static commonRedColorSignButtonWithoutIcon(
      {required String name, dynamic onTap}) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.height / 17,
          // width: Get.width / 2.3,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffE32525),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CommonText.textBold700P(
            text: name,
          ),
        ),
      ),
    );
  }

  static commonSignButtonWithoutIcon({required String name, dynamic onTap}) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.height / 17,
          // width: Get.width / 1.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorPicker.buttonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CommonText.textBold700P(
            text: name,
          ),
        ),
      ),
    );
  }

  static commonShortSizeSignButtonWithoutIcon(
      {required String name, dynamic onTap}) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.height / 17,
          // width: Get.width / 1.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorPicker.buttonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CommonText.textBold700P(
            text: name,
          ),
        ),
      ),
    );
  }
}
