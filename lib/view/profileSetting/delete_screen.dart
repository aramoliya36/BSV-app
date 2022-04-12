import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DeleteMyAccount extends StatefulWidget {
  const DeleteMyAccount({Key? key}) : super(key: key);

  @override
  _DeleteMyAccountState createState() => _DeleteMyAccountState();
}

class _DeleteMyAccountState extends State<DeleteMyAccount> {
  BottomController _bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
          color: ColorPicker.themBlackColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.appBarWithTitleBottom(
                  title: "Delete  My Account",
                  function: () {
                    _bottomController.bottomIndex.value = 3;
                    _bottomController.selectedScreen('AccountScreen');
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50.sp,
                          height: 50.sp,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                PreferenceManager.getImage(),
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textMediumDynamicColorP(
                                text: PreferenceManager.getNotSearchHandel(),
                                textColor: ColorPicker.whiteColor,
                                textSize: 15.sp),
                            CommonText.textLightDynamicW300(
                                text: PreferenceManager.getFnameId(),
                                textColor: ColorPicker.whiteColor,
                                textSize: 10.sp)
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/alert.svg"),
                        SizedBox(
                          width: Get.width * 0.04,
                        ),
                        CommonText.textSemiBoldDynamicP(
                            text: "Deleting your +App account will:",
                            textColor: Color(0xffE32525))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        children: [
                          buildRowText(title: "Delete your account from +App "),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          buildRowText(
                              title:
                                  "Erase your message, call and video history "),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          buildRowText(title: "Delete your account from +App "),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/ChangeEmail.svg"),
                        SizedBox(
                          width: Get.width * 0.04,
                        ),
                        CommonText.textMediumDynamicColorP(
                            text: "Change your Email instead?",
                            textColor: ColorPicker.whiteColor)
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 42),
                        child: CommonButton.commonSignButtonWithoutIcon(
                            name: "CHANGE EMAIL")),
                    SizedBox(
                      height: Get.height * 0.25,
                    ),
                    CommonButton.commonRedColorSignButtonWithoutIcon(
                        name: "DELETE MY ACCOUNT", onTap: () {})
                  ],
                ),
              )
            ],
          )),
      onWillPop: () {
        _bottomController.bottomIndex.value = 3;
        _bottomController.selectedScreen('AccountScreen');
        return Future.value(false);
      },
    );
  }

  Widget buildRowText({
    String? title,
  }) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
        ),
        SizedBox(
          width: Get.width * 0.03,
        ),
        CommonText.textMediumDynamicColor400(
            text: title!, textColor: ColorPicker.whiteColor, textSize: 10.sp)
      ],
    );
  }
}
