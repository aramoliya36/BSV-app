import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/model/services/firebase_auth.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  TextEditingController currentEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  BottomController _bottomController = Get.find();
  bool isEmailValid = false;
  bool isEmailValid1 = false;
  @override
  void dispose() {
    currentEmailController.dispose();
    newEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ProgressHUD(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Builder(
              builder: (context) => Material(
                  color: ColorPicker.themBlackColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.appBarWithTitleBottom(
                          title: "Current Email",
                          function: () {
                            _bottomController.bottomIndex.value = 3;
                            _bottomController.selectedScreen('AccountScreen');
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textSemiBoldDynamicP(
                                text: "Current Email",
                                textColor: ColorPicker.whiteColor,
                                fontSize: 13.sp),

                            ///========Current Email TextField==========///
                            CommonTextFiled.commonUnderLineTextFiled(
                                controller: currentEmailController,
                                // hintText: 'Email Address',
                                onChange: (v) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(currentEmailController.text)) {
                                    isEmailValid = true;
                                    print('is all valid $isEmailValid');
                                  } else {
                                    print('is all novalid $isEmailValid');

                                    isEmailValid = false;
                                  }
                                }),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CommonText.textSemiBoldDynamicP(
                                text: "New Email",
                                textColor: ColorPicker.whiteColor,
                                fontSize: 13.sp),

                            ///========New Email TextField==========///
                            CommonTextFiled.commonUnderLineTextFiled(
                                controller: newEmailController,
                                // hintText: 'New Address',
                                onChange: (v) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(newEmailController.text)) {
                                    isEmailValid1 = true;
                                    print('is all valid $isEmailValid1');
                                  } else {
                                    print('is all novalid $isEmailValid1');

                                    isEmailValid1 = false;
                                  }
                                }),

                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            CommonText.textSemiBoldDynamicP(
                                text: "Password",
                                textColor: ColorPicker.whiteColor,
                                fontSize: 13.sp),

                            ///========Common Confirm PassWord TextField==========///
                            CommonTextFiled.commonUnderLineTextFiled(
                                controller: passwordController,
                                hintText: 'At least 8 characters',
                                onChange: (v) {}),

                            SizedBox(
                              height: Get.height * 0.32,
                            ),
                            Center(
                              child: CommonButton
                                  .commonShortSizeSignButtonWithoutIcon(
                                      name: "Confirm Email",
                                      onTap: () async {
                                        final progress =
                                            ProgressHUD.of(context);

                                        if (currentEmailController
                                                .text.isNotEmpty &&
                                            newEmailController
                                                .text.isNotEmpty &&
                                            passwordController
                                                .text.isNotEmpty) {
                                          if (isEmailValid == true &&
                                              isEmailValid1 == true) {
                                            print(
                                                '----- ${PreferenceManager.getEmailId()}');
                                            if (currentEmailController.text ==
                                                PreferenceManager
                                                    .getLoginValue()) {
                                              if (currentEmailController.text !=
                                                  newEmailController.text) {
                                                try {
                                                  progress?.show();
                                                  await kFirebaseAuth
                                                      .signInWithEmailAndPassword(
                                                          email:
                                                              currentEmailController
                                                                  .text,
                                                          password:
                                                              passwordController
                                                                  .text);
                                                  PreferenceManager.getStorage
                                                      .remove('Email');
                                                  PreferenceManager
                                                      .setLoginValue(
                                                          newEmailController
                                                              .text);
                                                  RegisterRepo.resetEmail(
                                                          newEmail:
                                                              newEmailController
                                                                  .text)
                                                      .then((value) {
                                                    CommonSnackBar.showSnackBar(
                                                        successStatus: true,
                                                        msg:
                                                            "Email Is Successfully Change");
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      _bottomController
                                                          .selectedScreen(
                                                              'AccountScreen');
                                                      _bottomController
                                                          .bottomIndex
                                                          .value = 3;
                                                      progress?.dismiss();
                                                    });
                                                  });
                                                } on FirebaseAuthException catch (e) {
                                                  progress?.dismiss();
                                                  CommonSnackBar.showSnackBar(
                                                      msg: '${e.message}',
                                                      successStatus: false);
                                                }
                                              } else {
                                                CommonSnackBar.showSnackBar(
                                                    msg:
                                                        'Current email & new email are same',
                                                    successStatus: false);
                                              }
                                            } else {
                                              CommonSnackBar.showSnackBar(
                                                  msg:
                                                      'Current email is not valid',
                                                  successStatus: false);
                                            }
                                          } else {
                                            CommonSnackBar.showSnackBar(
                                                msg: 'Please enter valid email',
                                                successStatus: false);
                                          }
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              msg: 'Please enter all details',
                                              successStatus: false);
                                        }
                                      }),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
      onWillPop: () {
        _bottomController.bottomIndex.value = 3;
        _bottomController.selectedScreen('AccountScreen');
        return Future.value(false);
      },
    );
  }
}
