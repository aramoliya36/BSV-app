import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'choose_preference.dart';

class ConfirmBooking extends StatefulWidget {
  final String isTime;
  const ConfirmBooking({Key? key, required this.isTime}) : super(key: key);

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  ScheduleViewModel _scheduleViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(ChoosePreference());
        },
        child: CommonWidget.svgPicture(
          image: 'assets/svg/right_arrow.svg',
        ),
      ),
      backgroundColor: ColorPicker.themBlackColor,
      appBar: CommonWidget.appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText.textSemiBoldP(text: 'Confirm booking'),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonSizeBox.commonSizeBox(width: Get.width * .01),
                  SvgPicture.asset(
                    'assets/svg/calender_icon.svg',
                    color: ColorPicker.hintTextColor,
                  ),
                  CommonSizeBox.commonSizeBox(width: Get.width * .02),
                  Expanded(
                    child: CommonText.textSemiBoldDynamicP(
                        text: widget.isTime +
                            " " +
                            _scheduleViewModel.datePicker
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '') +
                            '(Europe/London)',
                        textColor: ColorPicker.hintTextColor,
                        fontSize: 12.sp),
                  )
                ],
              ),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              Row(
                children: [
                  Container(
                    height: 20.sp,
                    child: SvgPicture.asset(
                      'assets/svg/time_svg.svg',
                    ),
                  ),
                  CommonSizeBox.commonSizeBox(width: Get.height * .01),
                  Expanded(
                    child: CommonText.textSemiBoldDynamicP(
                        text: '30 mins',
                        fontSize: 13.sp,
                        textColor: ColorPicker.hintTextColor),
                  ),
                ],
              ),
              CommonSizeBox.commonSizeBox(height: Get.height * .02),
              CommonText.textSemiBoldDynamicP(
                  text: 'Name',
                  fontSize: 13.sp,
                  textColor: ColorPicker.whiteColor),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              CommonTextFiled.commonTextFiled(
                  hintText: '', controller: _nameController, onChange: (v) {}),
              CommonSizeBox.commonSizeBox(height: Get.height * .03),
              CommonText.textSemiBoldDynamicP(
                  text: 'Email',
                  fontSize: 13.sp,
                  textColor: ColorPicker.whiteColor),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              CommonTextFiled.commonTextFiled(
                  hintText: '', controller: _emailController, onChange: (v) {}),
            ],
          ),
        ),
      ),
    );
  }
}
