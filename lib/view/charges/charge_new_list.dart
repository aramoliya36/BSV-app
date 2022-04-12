import 'package:consultancy/ViewModel/charge_new_list_viewmodel.dart';
import 'package:consultancy/ViewModel/new_app_charge_controller.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewList extends StatefulWidget {
  const NewList({Key? key}) : super(key: key);

  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  TextEditingController _textEditingController = TextEditingController();
  String? dropdownvalue;
  int _itemCount = 0;
  int _itemCount1 = 0;
  int i = 0;
  var items = [
    'Australian Dollar (AUS)',
    'Nigerian Naira (NGN)',
    'US Dollar (USD)',
    'Pound Sterling (GBP)',
    'South African Rand (ZAR)',
  ];
  late TextEditingController _mController;
  late TextEditingController _cController;
  late TextEditingController _vController;
  late TextEditingController _moneyController;
  BottomController _bottomController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    _mController = TextEditingController(text: '0.0');
    _cController = TextEditingController(text: '0.0');
    _vController = TextEditingController(text: '0.0');
    _moneyController = TextEditingController(text: '0.0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      appBar: CommonWidget.appBarWithTitleBottom(
          title: '+New List',
          function: () {
            _bottomController.bottomIndex.value = 3;
            _bottomController.selectedScreen('AppCharges');
          }),
      body: WillPopScope(
        child: GetBuilder<NewAppChargeController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textSemiBoldP(text: 'List Name'),
                    CommonSizeBox.commonSizeBox(height: Get.height * .01),

                    CommonTextFiled.commonTextFiled(
                        hintText: 'Family & Friends FREE LIST ',
                        controller: _textEditingController,
                        onChange: (v) {}),

                    TextButton(
                      onPressed: () {},
                      child: CommonText.textSemiBoldDynamicP(
                          text: '+ ADD CONTACTS',
                          textColor: Colors.white,
                          fontSize: 12.sp),
                    ),

                    CommonText.textSemiBoldP(text: 'Currency'),
                    // Text('Currency'),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),

                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: GetBuilder<ChargeListViewModel>(
                          builder: (controller) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonText.textSemiBoldDynamicP(
                                      fontSize: 12.sp,
                                      textColor: ColorPicker.whiteColor,
                                      text: 'Select a Currency'),
                                  IconButton(
                                      onPressed: () {
                                        controller.setIsDro();
                                      },
                                      icon: controller.isDro
                                          ? Icon(
                                              Icons.keyboard_arrow_up_outlined,
                                              color: ColorPicker.whiteColor,
                                            )
                                          : Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: ColorPicker.whiteColor,
                                            )),
                                ],
                              ),
                              controller.isDro
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(
                                            color: Color(0xff838393),
                                          ),
                                          // isTap: controller.isDropMenu),
                                          CommonSizeBox.commonSizeBox(
                                              height: 5.sp),

                                          CommonText.textSemiBoldDynamicP(
                                              text: 'Pound Sterling (GBP)',
                                              fontSize: 10.sp,
                                              textColor:
                                                  ColorPicker.hintTextColor),
                                          CommonSizeBox.commonSizeBox(
                                              height: 10.sp),
                                          CommonText.textSemiBoldDynamicP(
                                              text: 'BitcoinSV',
                                              fontSize: 10.sp,
                                              textColor:
                                                  ColorPicker.hintTextColor),
                                        ],
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ColorPicker.whiteColor)),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),

                    chargeWidget(
                      controller: _mController,
                      chargeText: controller.isMessageCharge,
                      inTapDecrement: () {
                        if (controller.isMessageCharge >= 0.1) {
                          double m = controller.isMessageCharge -= 0.1;
                          _mController =
                              TextEditingController(text: m.toString());
                          controller.setMessageCharge(value: m);
                        }
                      },
                      onTapIncrement: () {
                        double m = controller.isMessageCharge += 0.1;
                        _mController =
                            TextEditingController(text: m.toString());

                        controller.setMessageCharge(value: m);
                      },
                      image: 'assets/svg/chat_left.svg',
                      text: 'Charge per message',
                      title: 'Messages',
                    ),

                    chargeWidget(
                        controller: _cController,
                        chargeText: controller.isCallCharge,
                        inTapDecrement: () {
                          if (controller.isCallCharge >= 0.1) {
                            double m = controller.isCallCharge -= 0.1;
                            _cController =
                                TextEditingController(text: m.toString());
                            controller.setCallCharge(value: m);
                          }
                        },
                        onTapIncrement: () {
                          double m = controller.isCallCharge += 0.1;
                          _cController =
                              TextEditingController(text: m.toString());

                          controller.setCallCharge(value: m);
                        },
                        image: 'assets/svg/call_bold_icon.svg',
                        text: 'Charge per Minute',
                        title: 'Voice Call'),
                    chargeWidget(
                        controller: _vController,
                        chargeText: controller.isVideoCharge,
                        inTapDecrement: () {
                          if (controller.isVideoCharge >= 0.1) {
                            double m = controller.isVideoCharge -= 0.1;
                            _vController =
                                TextEditingController(text: m.toString());
                            controller.setVideoCharge(value: m);
                          }
                        },
                        onTapIncrement: () {
                          double m = controller.isVideoCharge += 0.1;
                          _vController =
                              TextEditingController(text: m.toString());
                          controller.setVideoCharge(value: m);
                        },
                        image: 'assets/svg/video_icon.svg',
                        text: 'Charge per Minute',
                        title: 'Video Call'),
                    chargeWidget(
                        controller: _moneyController,
                        chargeText: controller.isBitcoinCharge,
                        inTapDecrement: () {
                          if (controller.isBitcoinCharge >= 0.1) {
                            double m = controller.isBitcoinCharge -= 0.1;
                            _moneyController =
                                TextEditingController(text: m.toString());
                            controller.setBitcoinCharge(value: m);
                          }
                        },
                        onTapIncrement: () {
                          double m = controller.isBitcoinCharge += 0.1;
                          _moneyController =
                              TextEditingController(text: m.toString());

                          controller.setBitcoinCharge(value: m);
                        },
                        image: 'assets/svg/money_icon.svg',
                        text: 'Charges start after',
                        title: 'Free minutes at the start of call?'),
                    CommonSizeBox.commonSizeBox(height: Get.height * .01),

                    CommonButton.commonSignButtonWithoutIcon(
                        name: 'APPLY', onTap: () {}),
                    CommonSizeBox.commonSizeBox(height: Get.height * .03),
                  ],
                ),
              ),
            );
          },
        ),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('AppCharges');
          return Future.value(false);
        },
      ),
    );
  }

  Column chargeWidget(
      {String? image,
      String? text,
      String? title,
      TextEditingController? controller,
      double? chargeText,
      dynamic onTapIncrement,
      dynamic inTapDecrement}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.textSemiBoldDynamicP(
            text: title!, fontSize: 12.sp, textColor: ColorPicker.whiteColor),
        CommonSizeBox.commonSizeBox(height: 9.sp),
        Row(
          children: [
            Container(
              height: 20.sp,
              child: CommonWidget.svgPicture(image: image!),
            ),
            CommonSizeBox.commonSizeBox(width: 10.sp),
            CommonText.textMediumDynamicColorP(
                text: text!, textColor: ColorPicker.whiteColor, textSize: 9.sp),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              width: 130,
              height: 26.sp,
              child: Row(
                children: [
                  IconButton(
                      icon: CommonWidget.svgPicture(
                        image: 'assets/svg/substract.svg',
                      ),
                      onPressed: inTapDecrement),
                  // Spacer(),
                  Expanded(
                      child: TextFormField(
                    controller: controller,
                    cursorColor: Colors.white,
                    style: CommonText.textStyleSemiBold600Normal(),
                    decoration: InputDecoration(border: InputBorder.none),
                  )),
                  // CommonText.textMediumDynamicColorP(
                  //     text: chargeText!.toStringAsFixed(1),
                  //     textColor: ColorPicker.whiteColor,
                  //     textSize: 12.sp),
                  // Spacer(),
                  IconButton(
                      icon: CommonWidget.svgPicture(
                        image: 'assets/svg/incre.svg',
                      ),
                      onPressed: onTapIncrement)
                ],
              ),
            ),
          ],
        ),
        CommonSizeBox.commonSizeBox(height: 9.sp),
      ],
    );
  }
}
