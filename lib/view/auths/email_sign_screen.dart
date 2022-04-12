import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/Common/button_common.dart';
import 'package:consultancy/Common/coomon_snackbar.dart';
import 'package:consultancy/Common/size_box.dart';
import 'package:consultancy/Common/text_filed.dart';
import 'package:consultancy/Res/Colors/colors_class.dart';
import 'package:consultancy/Res/Text/text_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/model/services/firebase_auth.dart';
import 'package:consultancy/view/auths/register_screen.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:consultancy/view/charges/by_default_screen.dart';
import 'package:consultancy/view/profileSetting/account_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'change_password.dart';

class EmailSignScreen extends StatefulWidget {
  const EmailSignScreen({Key? key}) : super(key: key);

  @override
  _EmailSignScreenState createState() => _EmailSignScreenState();
}

class _EmailSignScreenState extends State<EmailSignScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? isEmailValid;
  bool _passwordVisible = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonSizeBox.commonSizeBox(height: Get.height / 16),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: SvgPicture.asset(
                    //     'assets/svg/back_icon.svg',
                    //   ),
                    // ),
                    CommonSizeBox.commonSizeBox(height: Get.height / 26),
                    Center(child: SvgPicture.asset('assets/svg/app_icon.svg')),
                    CommonSizeBox.commonSizeBox(height: Get.height / 20),
                    CommonText.textSemiBoldP(text: 'Sign in'),
                    CommonSizeBox.commonSizeBox(height: Get.height / 60),
                    CommonTextFiled.commonTextFiled(
                        controller: emailController,
                        hintText: 'Enter your gmail address',
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
                    TextFormField(
                      obscureText: !_passwordVisible,
                      style: TextStyle(
                          color: ColorPicker.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                      onChanged: (v) {},
                      controller: passwordController,
                      cursorColor: ColorPicker.whiteColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: ColorPicker.hintTextColor, width: 1.5),
                        ),
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.all(10.sp),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorPicker.whiteColor,
                            )),
                        hintStyle: TextStyle(
                            color: ColorPicker.hintTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            fontFamily: 'Poppins'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: ColorPicker.hintTextColor, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                              color: ColorPicker.hintTextColor, width: 1.5),
                        ),
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: 5.sp),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          if (emailController.text.isNotEmpty) {
                            if (isEmailValid == true) {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: emailController.text.trim());
                                CommonSnackBar.showSnackBar(
                                    successStatus: false,
                                    msg: 'Verify send in your email');
                              } on FirebaseAuthException catch (e) {
                                print(e.code);
                                print(e.message);
                                CommonSnackBar.showSnackBar(
                                    successStatus: false, msg: '${e.message}');
                              }
                              // Get.to(ChangePassword(
                              //   email: emailController.text,
                              // ));
                            } else {
                              CommonSnackBar.showSnackBar(
                                  successStatus: false,
                                  msg: 'Email is not valid');
                            }
                          } else {
                            CommonSnackBar.showSnackBar(
                                successStatus: false,
                                msg: 'Please enter email');
                          }
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              color: ColorPicker.whiteColor),
                        ),
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: 80.sp),
                    CommonButton.commonSignButtonWithoutIcon(
                        name: 'SIGN IN',
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            if (isEmailValid == true) {
                              final progress = ProgressHUD.of(context);
                              progress?.show();
                              try {
                                await kFirebaseAuth.signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text);
                                await RegisterRepo.emailLogin(
                                    email: emailController.text.trim(),
                                    pass: passwordController.text);
                                String uid = _auth.currentUser!.uid;
                                print('---------uid in current user $uid');
                                PreferenceManager.setTokenId(uid);
                                PreferenceManager.setLoginValue(
                                    emailController.text);
                                PreferenceManager.setEmailId(
                                    emailController.text);
                                PreferenceManager.setLoginType('email');

                                navigatorScreen(progress: progress);
                                progress?.dismiss();
                              } on FirebaseAuthException catch (e) {
                                progress?.dismiss();
                                CommonSnackBar.showSnackBar(
                                    successStatus: false, msg: '${e.message}');
                              }
                            } else {
                              CommonSnackBar.showSnackBar(
                                  successStatus: false,
                                  msg: 'Email is not valid');
                            }
                          } else {
                            CommonSnackBar.showSnackBar(
                                successStatus: false,
                                msg: 'Please valid details');
                          }
                        }),
                    CommonSizeBox.commonSizeBox(height: 20.sp),
                    CommonText.textMediumP(
                        text: 'Don’t already have an account?'),
                    InkWell(
                      child: CommonText.textBold700PDynamicP(
                          text: 'Sign up here',
                          textColor: ColorPicker.whiteColor,
                          fontSize: 11.sp),
                      onTap: () {
                        Get.to(RegisterScreen());
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  bool? exist;

  Future<bool?> checkExist() async {
    try {
      await FirebaseFirestore.instance
          .collection("UserAllData")
          .doc(PreferenceManager.getTokenId())
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  navigatorScreen({final progress}) async {
    // await checkExist();

    await checkExist();
    print('---------exist $exist');
    if (exist == true) {
      var collection = FirebaseFirestore.instance
          .collection('UserAllData')
          .doc(PreferenceManager.getTokenId());
      var querySnapshot = await collection.get();

      if (querySnapshot['profileDetails'] == true) {
        PreferenceManager.setNotSearchHandel(querySnapshot['user_name']);
        PreferenceManager.setNotSearchName(querySnapshot['name']);

        PreferenceManager.setFnameId(querySnapshot['name']);
        PreferenceManager.setImage(querySnapshot['userImage']);
        PreferenceManager.setWalletId(querySnapshot['relysia_wallet_id']);
        PreferenceManager.setTransferId(querySnapshot['transaction_id']);
        PreferenceManager.setRelasiyaToken(querySnapshot['relysia_token']);

        FirebaseFirestore.instance
            .collection('UserAllData')
            .doc(querySnapshot['auth_Token'])
            .update({'fcm_token': PreferenceManager.getFcmToken()});
        if (querySnapshot['isCharges'] == false) {
          Get.offAll(AppCharges());
          progress?.dismiss();
        } else {
          Get.offAll(NavigationBarScreen());
          progress?.dismiss();
        }
      } else {
        Get.offAll(ByDefaultScreen());
        progress?.dismiss();
      }
    } else {
      Get.offAll(ByDefaultScreen());
      progress?.dismiss();
    }
  }
}
