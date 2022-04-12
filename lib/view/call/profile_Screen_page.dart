import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/calling_screen_controller.dart';
import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/call/voice_call_time_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../delet_new_charge.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({Key? key}) : super(key: key);

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  VoiceCallScreenController _voiceCallScreenController = Get.find();
  BottomController _bottomController = Get.find();
  ScheduleViewModel _scheduleViewModel = Get.find();

  @override
  void initState() {
    if (_bottomController.isRingtone.value == false) {
      FlutterRingtonePlayer.playRingtone();
      // FlutterRingtonePlayer.play(
      //   android: AndroidSounds.ringtone,
      //   ios: IosSounds.glass,
      //   looping: true, // Android only - API >= 28
      //   // Android only - API >= 28
      //   asAlarm: false, // Android only - all APIs
      // );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _handleCameraAndMic(Permission permission) async {
      final status = await permission.request();
      print(status);
    }

    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: ConfirmationSlider(
          backgroundColor: Color(0xffD9D8D3),
          height: 60,
          width: 300,
          backgroundShape: BorderRadius.circular(30),
          foregroundColor: Color(0xff238C73),
          // foregroundShape: BorderRadius.circular(0.0),
          sliderButtonContent: Container(
            padding: EdgeInsets.all(10.sp),
            child:
                CommonWidget.svgPicture(image: 'assets/svg/call_bold_icon.svg'),
            height: 10,
          ),
          text: 'Swipe to Answer',
          textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff888484)),
          onConfirmation: () async {
            FlutterRingtonePlayer.stop();

            await _handleCameraAndMic(Permission.camera);
            await _handleCameraAndMic(Permission.microphone);

            FirebaseFirestore.instance
                .collection('UserAllData')
                .doc(_voiceCallScreenController.callerAuthToken)
                .update({'isCallReceived': true});
            FirebaseFirestore.instance
                .collection('UserAllData')
                .doc(PreferenceManager.getTokenId())
                .update({'isCallReceived': true});
            _scheduleViewModel.dateTimeCall = DateTime.now();

            Get.to(() => VoiceCallTimeScreenWidget(
                  isVideoALL: _voiceCallScreenController.isVideo,
                  tokenId: _voiceCallScreenController.tokenID,
                  channelName: _voiceCallScreenController.channelId,
                  callerAuthId: _voiceCallScreenController.callerAuthToken,
                ));
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 100),
              child:
                  CommonWidget.svgPicture(image: 'assets/svg/person_user.svg'),
            ),
            SizedBox(
              height: 20,
            ),
            CommonText.textSemiBoldP(
                text: _voiceCallScreenController.callerName),
            CommonSizeBox.commonSizeBox(height: 2.sp),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              color: const Color(0xff238C73),
              onPressed: () {},
              child: CommonText.textSemiBoldDynamicP(
                  text: '+Dale',
                  fontSize: 9.sp,
                  textColor: ColorPicker.whiteColor),
            ),
            CommonSizeBox.commonSizeBox(height: 2.sp),
            CommonText.textMediumDynamicColorP(
                text: '+App Audio call',
                textColor: Color(0xffA5A5A5),
                textSize: 14.sp),
          ],
        ),
      ),
    );
  }
}
