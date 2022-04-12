import 'package:consultancy/Common/button_common.dart';
import 'package:consultancy/Common/size_box.dart';
import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:consultancy/Res/Text/text_common.dart';
import 'package:consultancy/ViewModel/register_viewmodel.dart';
import 'package:consultancy/model/services/google_sign_in.dart';
import 'package:consultancy/view/auths/email_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'country_pick.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: GetBuilder<RegisterViewModel>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonSizeBox.commonSizeBox(height: Get.height / 10),
                  CommonSizeBox.commonSizeBox(height: 20.sp),
                  SvgPicture.asset('assets/svg/app_icon.svg'),
                  CommonSizeBox.commonSizeBox(height: 30.sp),
                  InkWell(
                    onTap: () {
                      Get.to(CountryPicker());
                    },
                    child: Container(
                      height: Get.height / 16,
                      //width: Get.width / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorPicker.whiteColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CommonSizeBox.commonSizeBox(width: 14),
                          SvgPicture.asset('assets/svg/mobile_r_i.svg'),
                          CommonSizeBox.commonSizeBox(width: 38),
                          CommonText.textMediumP(
                              text: 'Register with phone number'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height / 30),
                  InkWell(
                    onTap: () {
                      Get.to(EmailSignUpScreen());
                    },
                    child: Container(
                      height: Get.height / 16,
                      //width: Get.width / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorPicker.whiteColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CommonSizeBox.commonSizeBox(width: 14),
                          SvgPicture.asset('assets/svg/email_i.svg'),
                          CommonSizeBox.commonSizeBox(width: 38),
                          CommonText.textMediumP(text: 'Register with Email'),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height / 30),
                  CommonButton.commonButton(
                      iconImage: SvgPicture.asset('assets/svg/bitcoin.svg'),
                      name: 'Sign in with BitcoinSV Wallet',
                      onTap: () {
                        controller.isDropMenu = true;
                      },
                      isTap: controller.isDropMenu),
                  CommonSizeBox.commonSizeBox(height: Get.height / 40),
                  controller.isDropMenu == false
                      ? SizedBox()
                      : Container(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonText.textMediumP(text: 'Handcash'),
                                CommonText.textMediumP(text: 'Moneybutton'),
                                CommonText.textMediumP(text: 'RelayX'),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: ColorPicker.whiteColor)),
                        ),
                  CommonSizeBox.commonSizeBox(height: Get.height / 400),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.sp),
                    child: Stack(
                      children: [
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 40.sp, alignment: Alignment.center,
                            color: ColorPicker.themBlackColor,
                            // color: ColorPicker.themBlackColor,
                            child: CommonText.textMediumP(text: 'or'),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height / 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            SignInWithGoogle().signInWithGoogle();
                          },
                          icon: SvgPicture.asset('assets/svg/google_icon.svg')),
                      CommonSizeBox.commonSizeBox(width: 10.sp),
                      IconButton(
                          onPressed: () {},
                          icon:
                              SvgPicture.asset('assets/svg/facebook_icon.svg')),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
