import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'confirm_booking_step.dart';

class ScheduleMeeting extends StatefulWidget {
  const ScheduleMeeting({Key? key}) : super(key: key);

  @override
  _ScheduleMeetingState createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
  ScheduleViewModel _scheduleViewModel = Get.find();
  var date;
  List<String> text = [
    '13:00 - 13:30',
    '13:30 - 14:30',
    '14:00 - 14:30',
    '14:30 - 15:00',
    '15:00 - 15:30'
  ];
  String? converted24Time;
  @override
  void initState() {
    // TODO: implement initState
    date = _scheduleViewModel.datePicker;
    print(
        '------_scheduleViewModel.datePicker-------${_scheduleViewModel.datePicker}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      appBar: CommonWidget.appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF777794),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.all(10),
                height: Get.height / 16,
                width: double.infinity,
                // color: Color(0xFF777794),
                child: Center(
                  child: CommonText.textSemiBoldP(text: date),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Center(
                child:
                    CommonText.textRegularWhiteW400(text: 'Schedule a Meeting'),
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              CommonText.textSemiBoldP(text: 'What time works best?'),
              SizedBox(
                height: Get.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.textRegularW400(text: 'Europe/London'),
                ],
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: InkWell(
                      onTap: () {
                        Get.to(ConfirmBooking(
                          isTime: text[index].toString(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),

                        height: Get.height / 16,
                        width: double.infinity,
                        // color: Color(0xFF777794),
                        child: CommonText.textRegularWhiteW400(
                            text: text[index].toString()),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
