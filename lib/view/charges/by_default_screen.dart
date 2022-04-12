import 'package:consultancy/ViewModel/app_profile_controller.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/appProfile/app_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ByDefaultScreen extends StatefulWidget {
  const ByDefaultScreen({Key? key}) : super(key: key);

  @override
  _ByDefaultScreenState createState() => _ByDefaultScreenState();
}

class _ByDefaultScreenState extends State<ByDefaultScreen> {
  String? _radioValue = 'BitcoinSV';
  AppProfileController _appProfileController = Get.find();
  String? choice;
  String? gender;
  radioButtonChanges(value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'BitcoinSV':
          choice = value;
          break;
        case 'GBP £':
          choice = value;
          break;

        default:
          choice = '';
      }
      debugPrint(choice);
      gender = choice;
      //Debug the choice in console
    });
  }

  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            floatingActionButton: InkWell(
              onTap: () {
                //   PreferenceManager.getStorage.erase();

                _appProfileController.byDefaultCurrency = _radioValue!;
                print(
                    '_appProfileController.byDefaultCurrency  ${_appProfileController.byDefaultCurrency}');
                Get.to(AppProfile());
              },
              child: CommonWidget.svgPicture(
                image: 'assets/svg/right_arrow.svg',
              ),
            ),
            backgroundColor: ColorPicker.themBlackColor,
            appBar: CommonWidget.appBarWithTitleBottom(
                title: 'Manage Handles',
                function: () {
                  _bottomController.bottomIndex.value = 3;
                  _bottomController.selectedScreen('AppSettings');
                }),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow(
                        value: "BitcoinSV",
                        title: "BitcoinSV",
                        onChanged: () {
                          return radioButtonChanges('BitcoinSV');
                        }),
                    buildRow(
                        value: "GBP £",
                        title: "GBP £",
                        onChanged: () {
                          return radioButtonChanges('GBP £');
                        }),
                    CommonText.textMediumDynamicColorP(
                        textColor: ColorPicker.whiteColor,
                        textSize: 8.sp,
                        text:
                            '(KYC Verification Required, can take from 2miniutes)')
                  ]),
            )),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('AppSettings');
          return Future.value(false);
        });
  }

  Widget buildRow({String? value, String? title, dynamic onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        children: [
          InkWell(
            onTap: onChanged,
            child: Container(
              height: 15.sp,
              width: 15.sp,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 10.sp,
                  width: 10.sp,
                  decoration: BoxDecoration(
                      color: _radioValue == value ? Colors.black : Colors.white,
                      shape: BoxShape.circle),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
            ),
          ),
          CommonSizeBox.commonSizeBox(width: 16.sp),
          CommonText.textMediumDynamicColorP(
              text: title!, textColor: ColorPicker.whiteColor, textSize: 13.sp),
        ],
      ),
    );
  }
}
