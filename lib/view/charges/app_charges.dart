import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/app_charge_viewmodel.dart';
import 'package:consultancy/ViewModel/app_profile_controller.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppCharges extends StatefulWidget {
  const AppCharges({Key? key}) : super(key: key);

  @override
  _App_ChargesState createState() => _App_ChargesState();
}

class _App_ChargesState extends State<AppCharges> {
  BottomController _bottomController = Get.find();
  AppProfileController _appProfileController = Get.find();

  TextEditingController? _mController;
  TextEditingController? _cController;
  TextEditingController? _vController;
  TextEditingController? _moneyController;
  String? dropdownvalue;
  int _itemCount = 0;
  int _itemCount1 = 0;
  var documentID;
  int i = 0;
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  var items = [
    'Australian Dollar (AUS)',
    'Nigerian Naira (NGN)',
    'US Dollar (USD)',
    'Pound Sterling (GBP)',
    'South African Rand (ZAR)',
  ];
  var querySnapshot;

  // getNameId() async {
  //   var snapshot = FirebaseFirestore.instance
  //       .collection("UserAllData")
  //       .doc(PreferenceManager.getTokenId());
  //   querySnapshot = await snapshot.get();
  //   print('===========${querySnapshot['price_message'].runtimeType}');
  //
  //
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _mController!.dispose();
    _cController!.dispose();
    _vController!.dispose();
    _moneyController!.dispose();
    super.dispose();
  }

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
          title: 'Charges',
          function: () {
            _bottomController.bottomIndex.value = 3;
            _bottomController.selectedScreen('AppSettings');
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp),
          child: GetBuilder<AppChargeViewModel>(
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.textSemiBoldP(text: 'Currency'),
                // Text('Currency'),
                CommonSizeBox.commonSizeBox(height: Get.height * .02),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText.textSemiBoldDynamicP(
                                text: controller.selectVale == ''
                                    ? 'Select a Currency'
                                    : controller.selectVale,
                                fontSize: 13.sp,
                                textColor: ColorPicker.whiteColor),
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
                                        Icons.keyboard_arrow_down_outlined,
                                        color: ColorPicker.whiteColor,
                                      )),
                          ],
                        ),
                        controller.isDro
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      color: Color(0xff838393),
                                    ),
                                    // isTap: controller.isDropMenu),
                                    CommonSizeBox.commonSizeBox(height: 5.sp),

                                    InkWell(
                                      child: CommonText.textSemiBoldDynamicP(
                                          text: 'Pound Sterling (GBP)',
                                          fontSize: 10.sp,
                                          textColor: ColorPicker.hintTextColor),
                                      onTap: () {
                                        controller.selectVale =
                                            'Pound Sterling (GBP)';
                                      },
                                    ),
                                    CommonSizeBox.commonSizeBox(height: 10.sp),
                                    InkWell(
                                      onTap: () {
                                        controller.selectVale = 'BitcoinSV';
                                      },
                                      child: CommonText.textSemiBoldDynamicP(
                                          text: 'BitcoinSV',
                                          fontSize: 10.sp,
                                          textColor: ColorPicker.hintTextColor),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox()
                      ],
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
                      _mController = TextEditingController(text: m.toString());
                      controller.setMessageCharge(value: m);
                    }
                  },
                  onTapIncrement: () {
                    double m = controller.isMessageCharge += 0.1;
                    _mController = TextEditingController(text: m.toString());

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
                      _cController = TextEditingController(text: m.toString());

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
                      _vController = TextEditingController(text: m.toString());
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
                // Text('Voice Call'),

                CommonSizeBox.commonSizeBox(height: Get.height * .02),

                InkWell(
                  onTap: () {
                    _bottomController.bottomIndex.value = 3;
                    _bottomController.selectedScreen('NewList');
                  },
                  child: ListTile(
                    title: CommonText.textMediumDynamicColorP(
                        text: '+ New List',
                        textColor: ColorPicker.whiteColor,
                        textSize: 12.sp),
                    subtitle: CommonText.textMediumDynamicColorP(
                        text:
                            'Create List of Contacts with Personalised Charges',
                        textColor: ColorPicker.hintTextColor,
                        textSize: 10.sp),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: 20.sp),

                CommonButton.commonSignButtonWithoutIcon(
                    name: 'APPLY',
                    onTap: () async {
                      print(
                          '----apappap ${_appProfileController.byDefaultCurrency}');
                      print(
                          '--------- ${controller.selectVale.isNotEmpty ? controller.selectVale : _appProfileController.byDefaultCurrency.isEmpty ? 'BitcoinSV' : _appProfileController.byDefaultCurrency}');
                      await kFireStore
                          .collection("UserAllData")
                          .doc(PreferenceManager.getTokenId())
                          .update({
                        'price_message': _mController!.text,
                        'price_video': _vController!.text,
                        'price_audio': _cController!.text,
                        'charges_Start': _moneyController!.text,
                        'isCharges': true,
                        'payment_mode':
                            '${controller.selectVale.isNotEmpty ? controller.selectVale : _appProfileController.byDefaultCurrency.isEmpty ? 'BitcoinSV' : _appProfileController.byDefaultCurrency}'
                      });
                      Get.offAll(NavigationBarScreen());
                    })
              ],
            ),
          ),
        ),
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
