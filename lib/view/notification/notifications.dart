import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String? dropdownvalue;
  bool messages = false;
  bool calls = true;
  bool schedule_call = true;
  BottomController _bottomController = Get.find();
  var items = [
    'Plusit (Default)',
    'Plusit (Default)1',
    'Plusit (Default)2',
    'Plusit (Default)3',
    'Plusit (Default)4',
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorPicker.themBlackColor,
        appBar: CommonWidget.appBarWithTitleBottom(
            title: 'Notification',
            function: () {
              _bottomController.bottomIndex.value = 3;
              _bottomController.selectedScreen('AppSettings');
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.textBold700PDynamicP(
                    text: 'Sound', textColor: Colors.white, fontSize: 12.sp),
                SizedBox(
                  height: Get.height * .02,
                ),
                Container(
                  height: 40.sp,
                  padding: EdgeInsets.all(10.sp),
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: new BorderRadius.circular(14.0),
                    color: Colors.transparent,
                  ),
                  width: double.infinity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.transparent,
                    ),
                    child: DropdownButton(
                      underline: SizedBox(),
                      isExpanded: true,
                      value: dropdownvalue,
                      style: TextStyle(color: Colors.white),
                      hint: CommonText.textSemiBoldP(text: 'Plusit (Default)'),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30,
                      ),

                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBold700PDynamicP(
                        text: 'Messages',
                        textColor: Colors.white,
                        fontSize: 12.sp),
                    Switch(
                      activeColor: Color(0xFf22EC7F),
                      value: messages,
                      onChanged: (value) {
                        setState(() {
                          messages = !messages;
                        });

                        // save(value);
                        // setState(() {
                        //
                        // });
                      },
                    )
                  ],
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textBold700PDynamicP(
                        text: 'Calls',
                        textColor: Colors.white,
                        fontSize: 12.sp),
                    Switch(
                      activeColor: Color(0xFf22EC7F),
                      value: calls,
                      onChanged: (value) {
                        setState(() {
                          calls = !calls;
                        });

                        // save(value);
                        // setState(() {
                        //
                        // });
                      },
                    )
                  ],
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.textMediumDynamicColorP(
                        text: 'Scheduled calls 5 minutes in advance',
                        textColor: Colors.white,
                        textSize: 10.sp),
                    Switch(
                      activeColor: Color(0xFf22EC7F),
                      value: schedule_call,
                      onChanged: (value) {
                        setState(() {
                          schedule_call = !schedule_call;
                        });

                        // save(value);
                        // setState(() {
                        //
                        // });
                      },
                    )
                  ],
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * .02),
                CommonText.textBold700PDynamicP(
                    text: 'Get Notifications',
                    textColor: Colors.white,
                    fontSize: 12.sp),
              ],
            ),
          ),
        ),
        // body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       // Container(
        //       //   decoration: BoxDecoration(
        //       //     color: Color(0XFF626262),
        //       //     borderRadius: BorderRadius.circular(
        //       //       30.0,
        //       //     ),
        //       //   ),
        //       //   padding: EdgeInsets.all(10),
        //       //   child: Container(
        //       //     height: 45,
        //       //     decoration: BoxDecoration(
        //       //       color: Colors.grey[300],
        //       //       borderRadius: BorderRadius.circular(
        //       //         25.0,
        //       //       ),
        //       //     ),
        //       //     child: TabBar(
        //       //       controller: _tabController,
        //       //       // give the indicator a decoration (color and border radius)
        //       //       indicator: BoxDecoration(
        //       //         borderRadius: BorderRadius.circular(
        //       //           25.0,
        //       //         ),
        //       //         color: ColorPicker.buttonColor,
        //       //       ),
        //       //       labelColor: Colors.white,
        //       //       unselectedLabelColor: Colors.black,
        //       //       tabs: [
        //       //         Tab(
        //       //           text: 'All',
        //       //         ),
        //       //         Tab(
        //       //           text: 'Custom',
        //       //         ),
        //       //       ],
        //       //     ),
        //       //   ),
        //       // ),
        //       // // tab bar view here
        //       // Expanded(
        //       //   child: TabBarView(
        //       //     controller: _tabController,
        //       //     children: [
        //       //       // first tab bar view widget
        //       //       Center(
        //       //         child: Text(
        //       //           'Place Bid',
        //       //           style: TextStyle(
        //       //             fontSize: 25,
        //       //             fontWeight: FontWeight.w600,
        //       //           ),
        //       //         ),
        //       //       ),
        //       //
        //       //       // second tab bar view widget
        //       //       Center(
        //       //         child: Text(
        //       //           'Buy Now',
        //       //           style: TextStyle(
        //       //             fontSize: 25,
        //       //             fontWeight: FontWeight.w600,
        //       //           ),
        //       //         ),
        //       //       ),
        //       //     ],
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
      onWillPop: () {
        _bottomController.bottomIndex.value = 3;
        _bottomController.setSelectedScreen('AppSettings');
        return Future.value(false);
      },
    );
  }
}
