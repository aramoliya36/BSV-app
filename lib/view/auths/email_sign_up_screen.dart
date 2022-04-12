import 'package:consultancy/Common/coomon_snackbar.dart';
import 'package:consultancy/Common/size_box.dart';
import 'package:consultancy/Common/text_filed.dart';
import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:consultancy/Res/Text/text_common.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/model/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'email_verify_to_continue.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({Key? key}) : super(key: key);

  @override
  _EmailSignUpScreenState createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CommonSizeBox.commonSizeBox(height: Get.height / 16),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  'assets/svg/back_icon.svg',
                ),
              ),
            ),
            CommonSizeBox.commonSizeBox(height: Get.height / 26),
            Center(child: SvgPicture.asset('assets/svg/app_icon.svg')),
            CommonSizeBox.commonSizeBox(height: Get.height / 20),
            CommonText.textSemiBoldP(text: 'Email Sign Up '),
            CommonSizeBox.commonSizeBox(height: Get.height / 60),

            ///========Common Email TextField==========///
            CommonTextFiled.commonTextFiled(
                controller: emailController,
                hintText: 'Email Address',
                onChange: (v) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailController.text)) {
                    isEmailValid = true;
                    print('is all valid $isEmailValid');
                  } else {
                    print('is all novalid $isEmailValid');

                    isEmailValid = false;
                  }
                }),

            ///========Common PassWord TextField==========///

            CommonTextFiled.commonTextFiled(
                controller: passwordController,
                hintText: 'Password',
                onChange: (v) {}),

            ///========Common Confirm PassWord TextField==========///
            CommonTextFiled.commonTextFiled(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                onChange: (v) {}),

            CommonSizeBox.commonSizeBox(height: 150.sp),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  print("===Click====");
                  if (isEmailValid == true) {
                    if (passwordController.text.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty) {
                      if (passwordController.text.length >= 6 &&
                          confirmPasswordController.text.length >= 6) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          Get.to(EmailEndVerifyContinue(
                            email: emailController.text,
                            password: passwordController.text,
                          ));
                        } else {
                          CommonSnackBar.showSnackBar(
                              msg: "Please enter same password",
                              successStatus: false);
                        }
                      } else {
                        CommonSnackBar.showSnackBar(
                            msg: "Pasword must be 6 character",
                            successStatus: false);
                      }
                    } else {
                      CommonSnackBar.showSnackBar(
                          msg: "Please enter valid password",
                          successStatus: false);
                    }
                  } else {
                    CommonSnackBar.showSnackBar(
                        msg: "Please enter valid email", successStatus: false);
                  }
                },
                child: Container(
                    height: Get.height * 0.04,
                    width: Get.width * 0.2,
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: ColorPicker.whiteColor)),
                    child: Center(
                      child: CommonText.textBold700PDynamicP(
                          text: 'Verify', textColor: Color(0xff14D661)),
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
