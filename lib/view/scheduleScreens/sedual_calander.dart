import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/common_drawer.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class SedualCalander extends StatefulWidget {
  const SedualCalander({Key? key}) : super(key: key);

  @override
  _SedualCalanderState createState() => _SedualCalanderState();
}

String _selectedDate = '';
String _dateCount = '';
String _range = '';
String _rangeCount = '';

class _SedualCalanderState extends State<SedualCalander> {
  ScheduleViewModel _scheduleViewModel = Get.find();

  bool isSelect = false;
  String date = '';
  String? year = '';
  final now = DateTime.now();

  bool isSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPicker.themBlackColor,
      drawer: CommonDrawer.commonDrawer(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appCalenderBar(
                  title: "January",
                  onTap: () {
                    print("====Clicked=====>>$isSelect");
                    setState(() {
                      if (isSelected == false) {
                        isSelected = true;
                      } else {
                        isSelected = false;
                      }
                    });
                  },
                  svgPicture: "assets/svg/person_user.svg",
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.black,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isSelected == false
                      ? SizedBox()
                      : Container(
                          height: Get.height * 0.33,
                          width: Get.width,
                          color: Colors.transparent,
                          child: SfDateRangePicker(
                            onViewChanged: (dateRangePickerViewChangedArgs) {
                              print(
                                  '---------p0---------${dateRangePickerViewChangedArgs.view.index}');
                            },
                            onSubmit: (p0) {
                              print('---------p0---------$p0');
                            },
                            headerStyle: DateRangePickerHeaderStyle(
                                textStyle:
                                    CommonText.textStyleSemiBold600Normal()),
                            todayHighlightColor: ColorPicker.whiteColor,
                            yearCellStyle: DateRangePickerYearCellStyle(
                                textStyle:
                                    TextStyle(color: ColorPicker.whiteColor)),
                            monthCellStyle: DateRangePickerMonthCellStyle(
                                textStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: ColorPicker.whiteColor)),
                            backgroundColor: Colors.transparent,
                            enablePastDates: false,
                            onSelectionChanged: _onSelectionChanged,
                            view: DateRangePickerView.month,
                            minDate: DateTime(now.year, now.month, now.day + 1),
                            monthViewSettings: DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 1,
                                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                    textStyle: CommonText
                                        .textStyleSemiBold600Normal()),
                                weekNumberStyle: DateRangePickerWeekNumberStyle(
                                  backgroundColor: ColorPicker.whiteColor,
                                  textStyle:
                                      CommonText.textStyleSemiBold600Normal(),
                                )),
                          ),
                        ),
                  ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            CommonText.textSemiBoldDynamicP(
                                text: 'JAN', textColor: ColorPicker.whiteColor),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: Get.height * 0.045,
                                    width: Get.width * 0.09,
                                    decoration: BoxDecoration(
                                        color: ColorPicker.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: CommonText.textMediumDynamicColorP(
                                          text: "1", textSize: 18),
                                    )),
                                Container(
                                  height: Get.height * 0.12,
                                  width: Get.width * 0.8,
                                  decoration: BoxDecoration(
                                      color: index == 0
                                          ? Color(0xff777794)
                                          : Colors.transparent,
                                      border: Border.all(
                                          color: index == 0
                                              ? Colors.transparent
                                              : ColorPicker.whiteColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 13),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CommonText.textMediumDynamicColorP(
                                            text: "New Call Scheduled by Paula",
                                            textColor: ColorPicker.whiteColor,
                                            textSize: 14.sp),
                                        Row(
                                          children: [
                                            CommonText
                                                .textMediumDynamicColor400(
                                                    text: "+Paula",
                                                    textColor:
                                                        ColorPicker.whiteColor),
                                            SizedBox(
                                              width: Get.width * 0.04,
                                            ),
                                            CommonText.textSemiBoldDynamicP(
                                                text: '\$20.14',
                                                textColor:
                                                    ColorPicker.whiteColor)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.015,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 45),
                              child: Column(
                                children: [
                                  CommonText.textSemiBoldDynamicP(
                                      text: "JAN 2 - 12",
                                      textColor: ColorPicker.whiteColor),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                  CommonText.textSemiBoldDynamicP(
                                      text: "JAN 2 - 12",
                                      textColor: ColorPicker.whiteColor),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} '
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        String new_date = DateFormat('yyyy').format(args.value);
        String datetime3 = DateFormat.MMMMEEEEd().format(args.value);
        date = datetime3;
        year = new_date;
        print(new_date);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        // print(_dateCount);
      } else {
        _rangeCount = args.value.length.toString();
        // print(_rangeCount);
      }
    });
  }

  Widget appCalenderBar(
      {String? svgPicture, String? title, Icon? icon, dynamic onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Stack(
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
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 12.sp,
                  width: 12.sp,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorPicker.whiteColor, width: 2),
                      shape: BoxShape.circle,
                      color: ColorPicker.greenIndicatorColor),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10.sp,
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                CommonText.textMediumDynamicColor400(
                    text: title!,
                    textSize: 18,
                    textColor: ColorPicker.whiteColor),
                SizedBox(
                  width: Get.width * 0.015,
                ),
                Container(
                    height: Get.height * 0.03,
                    width: Get.width * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: icon!)
              ],
            ),
          )
        ],
      ),
    );
  }
}
