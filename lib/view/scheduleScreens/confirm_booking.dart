import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FinalBooking extends StatefulWidget {
  const FinalBooking({
    Key? key,
  }) : super(key: key);

  @override
  _FinalBookingState createState() => _FinalBookingState();
}

class _FinalBookingState extends State<FinalBooking> {
  ScheduleViewModel _scheduleViewModel = Get.find();
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CommonSizeBox.commonSizeBox(height: Get.height * .02),
              iconWidget(
                  image: 'assets/svg/calender_icon.svg',
                  text: " " +
                      _scheduleViewModel.datePicker
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '') +
                      '(Europe/London)'),
              CommonSizeBox.commonSizeBox(height: Get.height * .03),
              Row(
                children: [
                  Container(
                    height: 20.sp,
                    child: SvgPicture.asset(
                      'assets/svg/time_svg.svg',
                      color: ColorPicker.hintTextColor,
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
              CommonSizeBox.commonSizeBox(height: Get.height * .03),
              iconWidget(
                  text: 'Voice Call', image: 'assets/svg/call_bottom_icon.svg'),
              CommonSizeBox.commonSizeBox(height: Get.height * .03),
              iconWidget(
                  text: '\$1.20 per minute', image: 'assets/svg/wallet.svg'),
              CommonSizeBox.commonSizeBox(height: 240.sp),
              CommonButton.commonSignButtonWithoutIcon(
                  name: 'COMPLETE',
                  onTap: () {
                    Get.offAll(NavigationBarScreen());
                    _bottomController.bottomIndex.value = 3;
                    _bottomController.setSelectedScreen('UserHomeWidget');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Row iconWidget({String? image, String? text}) {
    return Row(
      children: [
        CommonSizeBox.commonSizeBox(width: 2.sp),
        Container(
          height: 20.sp,
          child: SvgPicture.asset(
            image!,
            color: ColorPicker.hintTextColor,
          ),
        ),
        CommonSizeBox.commonSizeBox(width: Get.height * .01),
        Expanded(
          child: CommonText.textSemiBoldDynamicP(
              text: text!,
              fontSize: 13.sp,
              textColor: ColorPicker.hintTextColor),
        ),
      ],
    );
  }
}
