import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonTextFiled {
  static commonTextFiled({
    String? hintText,
    TextEditingController? controller,
    bool isPrefix = false,
    dynamic onChange,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        style: TextStyle(
            color: ColorPicker.whiteColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins'),
        onChanged: onChange,
        controller: controller,
        cursorColor: ColorPicker.whiteColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide:
                BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.all(10.sp),
          hintStyle: TextStyle(
              color: ColorPicker.hintTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
              fontFamily: 'Poppins'),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide:
                BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide:
                BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  static Container commonUnderLineTextFiled({
    String? hintText,
    TextEditingController? controller,
    dynamic onChange,
  }) {
    return Container(
      // height: 6.h,
      //color: Colors.deepOrange,
      // margin: EdgeInsets.symmetric(vertical: 4.sp),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          autofocus: true,
          style: TextStyle(
              decorationColor: Colors.white,
              color: ColorPicker.whiteColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
          onChanged: onChange,
          controller: controller,
          cursorColor: ColorPicker.whiteColor,
          decoration: InputDecoration(
            isCollapsed: true,
            focusColor: Colors.white,
            hoverColor: Colors.white,

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),

            // border: OutlineInputBorder(
            //   // borderRadius: BorderRadius.all(Radius.circular(12)),
            //   borderSide:
            //       BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
            // ),
            // border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: hintText,

            contentPadding: EdgeInsets.all(10.sp),
            hintStyle: TextStyle(
                color: ColorPicker.hintTextColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(12)),
            //   borderSide:
            //       BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
            // ),

            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(12)),
            //   borderSide:
            //       BorderSide(color: ColorPicker.hintTextColor, width: 1.5),
            // ),
          ),
        ),
      ),
    );
  }
}
