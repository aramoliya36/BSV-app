import 'package:consultancy/ViewModel/country_pick_viewmode.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/customPackage/lib/country_code_picker.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'chnage_mobile_otp_screen.dart';
import 'otp_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class ChangeCountryPicker extends StatefulWidget {
  const ChangeCountryPicker({Key? key}) : super(key: key);

  @override
  _ChangeCountryPickerState createState() => _ChangeCountryPickerState();
}

class _ChangeCountryPickerState extends State<ChangeCountryPicker> {
  CountryPickViewModel _countryPickViewModel = Get.find();
  String? verificationId;
  BottomController _bottomController = Get.find();

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _oldEditingController = TextEditingController();
  bool showLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  var con;
  @override
  Widget build(BuildContext context) {
    // ModalProgressHUD

    return WillPopScope(
      child: GetBuilder<CountryPickViewModel>(
        builder: (controller) => Scaffold(
          floatingActionButton: InkWell(
            child: SvgPicture.asset('assets/svg/right_arrow.svg'),
            onTap: () async {
              if (_countryPickViewModel.isDropMenu != '') {
                print(PreferenceManager.getLoginValue());
                print(controller.countryCode + _oldEditingController.text);
                if (controller.countryCode + _oldEditingController.text ==
                    PreferenceManager.getLoginValue()) {
                  if (_textEditingController.text.length == 10) {
                    setState(() {
                      showLoading = true;
                    });

                    await _auth.verifyPhoneNumber(
                      phoneNumber:
                          controller.countryCode + _textEditingController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        // signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        print(
                            '----verificationFailed---${verificationFailed.message}');
                        CommonSnackBar.showSnackBar(
                            msg: verificationFailed.message,
                            successStatus: false);
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                          print(
                              '---------verificationId-------$verificationId');
                          print(
                              '---------this.verificationId-------${this.verificationId}');

                          Get.to(OtpScreenChangeNumber(
                            mobileNumber: controller.countryCode +
                                _textEditingController.text,
                            verificationId: verificationId,
                          ));
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  } else {
                    CommonSnackBar.showSnackBar(
                        msg: 'Please enter your mobile number');
                  }
                } else {
                  CommonSnackBar.showSnackBar(
                      msg: 'Please enter valid old mobile number');
                }
              } else {
                CommonSnackBar.showSnackBar(msg: 'Please choose a country');
              }
            },
          ),
          backgroundColor: ColorPicker.themBlackColor,
          body: showLoading
              ? circularProgress()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonSizeBox.commonSizeBox(height: Get.height / 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              _bottomController.selectedScreen('AccountScreen');
                              _bottomController.bottomIndex.value = 3;
                            },
                            child: SvgPicture.asset(
                              'assets/svg/back_icon.svg',
                            ),
                          ),
                        ),
                        CommonSizeBox.commonSizeBox(height: Get.height / 16),

                        CountryCodePicker(
                          onChanged: (value) {
                            // countryCode = value.dialCode.toString();
                            _countryPickViewModel.isDropMenu =
                                value.name.toString();
                            _countryPickViewModel.countryCode =
                                value.dialCode.toString();
                            print(
                                '---------COUNTRY CODE ${value.dialCode.toString()}');
                          },
                          //hideMainText: true,
                          initialSelection: "IN",
                          showCountryOnly: false,

                          showFlagDialog: true,
                          showOnlyCountryWhenClosed: true,
                          showFlag: false,
                          showDropDownButton: false,
                        ),
                        Divider(
                          thickness: 1,
                          color: ColorPicker.whiteColor,
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: Get.width / 6,
                              height: 63,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  CommonText.textMediumP(
                                      text:
                                          '${controller.countryCode.isNotEmpty ? controller.countryCode : '+'}'),
                                  Divider(
                                    thickness: 1,
                                    color: ColorPicker.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              //color: Colors.deepOrange,
                              width: Get.width / 1.6,
                              height: 50,
                              child: TextFormField(
                                controller: _oldEditingController,
                                cursorColor: ColorPicker.whiteColor,
                                style: CommonText.textStyleSemiBold600(),
                                keyboardType: TextInputType.number,

                                maxLength: 10, maxLengthEnforced: true,
                                // style: TextStyle(color: ColorPicker.whiteColor),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    counterText: '',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPicker.whiteColor),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPicker.whiteColor),
                                    ),
                                    fillColor: ColorPicker.whiteColor),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: Get.width / 6,
                              height: 63,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  CommonText.textMediumP(
                                      text:
                                          '${controller.countryCode.isNotEmpty ? controller.countryCode : '+'}'),
                                  Divider(
                                    thickness: 1,
                                    color: ColorPicker.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              //color: Colors.deepOrange,
                              width: Get.width / 1.6,
                              height: 50,
                              child: TextFormField(
                                controller: _textEditingController,
                                cursorColor: ColorPicker.whiteColor,
                                style: CommonText.textStyleSemiBold600(),
                                keyboardType: TextInputType.number,

                                maxLength: 10, maxLengthEnforced: true,
                                // style: TextStyle(color: ColorPicker.whiteColor),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    counterText: '',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPicker.whiteColor),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorPicker.whiteColor),
                                    ),
                                    fillColor: ColorPicker.whiteColor),
                              ),
                            ),
                          ],
                        ),
                        CommonSizeBox.commonSizeBox(height: Get.height / 40),

                        CommonText.textMediumP(
                            text:
                                'Please confirm your country code and enter your phone number.'),
                        CommonSizeBox.commonSizeBox(height: Get.height / 30),

                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/check.svg'),
                            CommonSizeBox.commonSizeBox(width: Get.width / 30),
                            CommonText.textSemiBoldDynamicP(
                              text: 'Sync Contacts',
                              textColor: ColorPicker.whiteColor,
                            )
                          ],
                        ),
                        Container(
                          height: 60,
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/check.svg'),
                              CommonSizeBox.commonSizeBox(
                                  width: Get.width / 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonText.textSemiBoldDynamicP(
                                      text: "Please confirm acceptance of ",
                                      textColor: ColorPicker.whiteColor),
                                  Row(
                                    children: [
                                      CommonText.textSemiBoldDynamicP(
                                          text: "+App’s ",
                                          textColor: ColorPicker.whiteColor),
                                      CommonText.textSemiBoldDynamicP(
                                          text: "terms & conditions",
                                          textColor: Color(0xffF0B8B8))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        //  TextFormField()
                      ],
                    ),
                  ),
                ),
        ),
      ),
      onWillPop: () {
        _bottomController.selectedScreen('AccountScreen');
        _bottomController.bottomIndex.value = 3;
        return Future.value(false);
      },
    );
  }
}
