import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/model/services/firebase_auth.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  final String email;
  const ChangePassword({required this.email}) : super();

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isEmailValid = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: ColorPicker.themBlackColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.appBarWithTitle(title: "Change Password"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textSemiBoldDynamicP(
                      text: "New Password",
                      textColor: ColorPicker.whiteColor,
                      fontSize: 13.sp),

                  ///========New Email TextField==========///
                  CommonTextFiled.commonUnderLineTextFiled(
                    controller: newPasswordController,
                    // hintText: 'New Address',
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CommonText.textSemiBoldDynamicP(
                      text: "Confirm New Password",
                      textColor: ColorPicker.whiteColor,
                      fontSize: 13.sp),

                  ///========Common Confirm PassWord TextField==========///
                  CommonTextFiled.commonUnderLineTextFiled(
                      controller: confirmNewPasswordController,
                      hintText: 'At least 8 characters',
                      onChange: (v) {}),

                  SizedBox(
                    height: Get.height * 0.32,
                  ),
                  Center(
                    child: CommonButton.commonShortSizeSignButtonWithoutIcon(
                        name: "Confirm Email",
                        onTap: () async {
                          if (newPasswordController.text.isNotEmpty &&
                              confirmNewPasswordController.text.isNotEmpty) {
                            if (newPasswordController.text ==
                                confirmNewPasswordController.text) {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: widget.email);
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                print(e.message);
// show the snackbar here
                              }
                            } else {
                              CommonSnackBar.showSnackBar(
                                  msg: "New & Confirm Password not match.",
                                  successStatus: false);
                            }
                          } else {
                            CommonSnackBar.showSnackBar(
                                msg: "Please enter the password.",
                                successStatus: false);
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
