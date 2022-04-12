import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorPicker.themBlackColor,
          appBar: CommonWidget.appBarWithTitleBottom(
              title: "Account",
              function: () {
                _bottomController.bottomIndex.value = 3;
                _bottomController.selectedScreen('AppSettings');
              }),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              builRow(
                  onTap: () {
                    _bottomController.selectedScreen('AccountInformation');
                    _bottomController.bottomIndex.value = 3;
                  },
                  title: "Account Information"),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              builRow(
                  onTap: () {
                    _bottomController.selectedScreen('PrivacyScreen');
                    _bottomController.bottomIndex.value = 3;
                  },
                  title: "Privacy"),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              builRow(onTap: () {}, title: "Two Step Verification"),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              PreferenceManager.getLoginType() == 'email'
                  ? builRow(
                      onTap: () {
                        _bottomController.selectedScreen('ChangeEmail');
                        _bottomController.bottomIndex.value = 3;
                      },
                      title: "Change Email")
                  : SizedBox(),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              PreferenceManager.getLoginType() == 'mobile'
                  ? builRow(
                      onTap: () {
                        _bottomController.selectedScreen('ChangeCountryPicker');
                        _bottomController.bottomIndex.value = 3;
                      },
                      title: "Change Phone Number")
                  : SizedBox(),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              builRow(onTap: () {}, title: "Change Password"),
              CommonSizeBox.commonSizeBox(height: Get.height * 0.0008),
              builRow(
                  onTap: () {
                    _bottomController.selectedScreen('DeleteMyAccount');
                    _bottomController.bottomIndex.value = 3;
                  },
                  title: "Delete My Account"),
            ],
          ),
        ),
        onWillPop: () {
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('AppSettings');

          return Future.value(false);
        });
  }

  Widget builRow({dynamic onTap, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.textSemiBoldDynamicP(
                text: title!, textColor: ColorPicker.whiteColor),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
              color: ColorPicker.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
