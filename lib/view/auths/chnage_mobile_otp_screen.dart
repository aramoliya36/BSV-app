import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/otp_screeen_controllert.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class OtpScreenChangeNumber extends StatefulWidget {
  const OtpScreenChangeNumber(
      {Key? key, this.verificationId, this.mobileNumber})
      : super(key: key);
  final String? verificationId;
  final String? mobileNumber;

  @override
  _OtpScreenChangeNumberState createState() => _OtpScreenChangeNumberState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _OtpScreenChangeNumberState extends State<OtpScreenChangeNumber>
    with TickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  BottomController _bottomController = Get.find();
  RegisterRelasiyaReqModel _user = RegisterRelasiyaReqModel();
  OtpScreenController _otpScreenController = Get.find();
  int? otpPin;
  AnimationController? _controller;
  int levelClock = 180;
  OtpFieldController otpController = OtpFieldController();
  TextEditingController? _textEditingController;

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    _otpScreenController.showLoading = true;

    try {
      _auth.currentUser!.updatePhoneNumber(phoneAuthCredential);

      _otpScreenController.showLoading = false;

      if (_auth.currentUser != null) {
        PreferenceManager.setLoginType('mobile');
        PreferenceManager.setLoginValue(widget.mobileNumber!);

        CommonSnackBar.showSnackBar(
            successStatus: true, msg: 'Login successful');
        Future.delayed(Duration(seconds: 2), () {
          Get.offAll(NavigationBarScreen());
          _bottomController.bottomIndex.value = 3;
          _bottomController.selectedScreen('UserHomeWidget');
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (context) {
          //     return NavigationBarScreen();
          //   },
          // ));
        });
      }
    } on FirebaseAuthException catch (e) {
      _otpScreenController.showLoading = false;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textEditingController!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.all(10),
          height: 10,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              'assets/svg/back_icon.svg',
            ),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          _otpScreenController.showLoading = true;

          print(
              '-----_textEditingController-----${_textEditingController!.text}');
          if (_textEditingController!.text.length == 6) {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: widget.verificationId!,
                    smsCode: _textEditingController!.text);

            await signInWithPhoneAuthCredential(phoneAuthCredential);

            _otpScreenController.showLoading = false;
          } else {
            _otpScreenController.showLoading = false;

            CommonSnackBar.showSnackBar(
                successStatus: false, msg: 'Please valid otp');
          }
        },
        child: SvgPicture.asset(
          'assets/svg/right_arrow.svg',
        ),
      ),
      body: GetBuilder<OtpScreenController>(
        builder: (controller) {
          return controller.showLoading
              ? circularProgress()
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            'assets/svg/otp_screen_icon.svg',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CommonText.textBold700P(text: 'Enter code'),
                        SizedBox(
                          height: 15,
                        ),
                        CommonText.textMediumP(
                            text:
                                'We’ve sent a SMS with an activation \n    code to your phone ${widget.mobileNumber}'),
                        SizedBox(
                          height: 15,
                        ),
                        OTPTextField(
                          onChanged: (value) {
                            //   setState(() {});
                          },
                          length: 6,
                          width: 300, controller: otpController,
                          fieldWidth: 30,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: ColorPicker.whiteColor),
                          // textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,

                          otpFieldStyle: OtpFieldStyle(
                              enabledBorderColor: ColorPicker.whiteColor,
                              errorBorderColor: ColorPicker.whiteColor,
                              //backgroundColor: ColorPicker.whiteColor,
                              borderColor: ColorPicker.whiteColor,
                              disabledBorderColor: ColorPicker.whiteColor,
                              focusBorderColor: ColorPicker.whiteColor),
                          onCompleted: (pin) {
                            print("Completed: }" + pin);
                            _textEditingController =
                                TextEditingController(text: pin.toString());
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Countdown(
                          animation: StepTween(
                            begin: levelClock,
                            end: 0,
                          ).animate(_controller!),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return CommonText.textMediumDynamicColorP(
        text: "$timerText", textColor: ColorPicker.whiteColor, textSize: 16.sp);
  }
}
