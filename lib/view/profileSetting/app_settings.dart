import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/avalibity/availabilty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  BottomController _bottomController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('--------ghjtg ${PreferenceManager.getImage().runtimeType}');
    String imagePr = PreferenceManager.getImage();
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorPicker.themBlackColor,
          appBar: CommonWidget.appBarWithTitleBottom(
              title: 'Settings',
              function: () {
                _bottomController.bottomIndex.value = 3;
                _bottomController.selectedScreen('UserHomeWidget');
              }),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          Container(
                            height: 36.sp,
                            width: 36.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey),
                            child: imagePr.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.network(imagePr,
                                        fit: BoxFit.cover))
                                : SizedBox(),
                          ),
                          SizedBox(
                            width: Get.width * .02,
                          ),
                          InkWell(
                            onTap: () {
                              _bottomController.bottomIndex.value = 3;
                              _bottomController
                                  .selectedScreen('ShowProfileApp');
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.textMediumDynamicColorP(
                                    text:
                                        '${PreferenceManager.getNotSearchHandel()}',
                                    textColor: ColorPicker.whiteColor,
                                    textSize: 14.sp),
                                CommonText.textMediumDynamicColorP(
                                    text: PreferenceManager.getFnameId() ?? '',
                                    textColor: ColorPicker.hintTextColor,
                                    textSize: 10.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CommonText.textLightDynamicW300(
                          text: 'https://www.plus-app/johnson',
                          textColor: ColorPicker.whiteColor,
                          textSize: 8.sp)
                    ],
                  ),
                ),
                listView(
                    image: 'assets/svg/add_icon.svg',
                    text: 'MANAGE HANDLES',
                    function: () {
                      _bottomController.bottomIndex.value = 3;
                      _bottomController.selectedScreen('ManageAccountSelect');
                    }),
                listView(
                    image: 'assets/svg/money_icon.svg',
                    text: 'CHARGES',
                    function: () {
                      _bottomController.bottomIndex.value = 2;
                      _bottomController.selectedScreen('OldAppCharges');
                    }),
                listView(
                    image: 'assets/svg/small_call.svg',
                    text: 'CALLS',
                    function: () {
                      _bottomController.bottomIndex.value = 3;
                      _bottomController.selectedScreen('CallScreen');
                    }),
                listView(image: 'assets/svg/chat_left.svg', text: 'CHATS'),
                listView(
                    image: 'assets/svg/ball.svg',
                    text: 'NOTIFICATIONS',
                    function: () {
                      _bottomController.bottomIndex.value = 4;
                      _bottomController.selectedScreen('Notifications');
                    }),
                listView(
                    image: 'assets/svg/key_icon.svg',
                    text: 'ACCOUNT',
                    function: () {
                      _bottomController.bottomIndex.value = 4;
                      _bottomController.selectedScreen('AccountScreen');
                    }),
                listView(
                    function: () {
                      _bottomController.bottomIndex.value = 3;
                      _bottomController.selectedScreen('AvailabiltyScreen');
                    },
                    image: 'assets/svg/help_icon.svg',
                    text: 'SET AVAILABILITY'),
                listView(
                    image: 'assets/svg/person_icon.svg',
                    text: 'INVITE A CONTACT'),
                CommonSizeBox.commonSizeBox(height: Get.height * .01),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Manage Wallets',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    )),
                CommonSizeBox.commonSizeBox(height: Get.height * .01),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                  leading: CommonWidget.svgPicture(
                      image: 'assets/svg/bitcoin_icon.svg'),
                  title: CommonText.textMediumDynamicColorP(
                      text: 'BitcoinSV',
                      textColor: Colors.white,
                      textSize: 14.sp),
                  subtitle: CommonText.textMediumDynamicColorP(
                      text: 'Check balance, withdraw and deposit',
                      textColor: Colors.grey,
                      textSize: 10.sp),
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * .01),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                  leading: CommonWidget.svgPicture(
                    image: 'assets/svg/pound_icon.svg',
                  ),
                  title: CommonText.textMediumDynamicColorP(
                      text: 'GBP ', textColor: Colors.white, textSize: 14.sp),
                  subtitle: CommonText.textMediumDynamicColorP(
                      text: 'Check balance, withdraw and deposit',
                      textColor: Colors.grey,
                      textSize: 10.sp),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('UserHomeWidget');
          return Future.value(false);
        });
  }

  Widget listView({String? image, String? text, dynamic function}) {
    return InkWell(
      onTap: function,
      child: ListTile(
        leading: CommonWidget.svgPicture(image: image!),
        title: CommonText.textMediumDynamicColorP(
            text: text!, textColor: Colors.white, textSize: 12.sp),
      ),
    );
  }
}
