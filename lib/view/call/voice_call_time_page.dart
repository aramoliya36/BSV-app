import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/calling_screen_controller.dart';
import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/ViewModel/send_money_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/requestModel/send_money_req_model.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/chat/chatUi/rooms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine/rtc_engine.dart' as rtc;
import 'package:http/http.dart' as http;

class VoiceCallTimeScreenWidget extends StatefulWidget {
  final String? tokenId;
  final String? channelName;
  final String? callerAuthId;
  final bool? isVideoALL;
  final String? transferId;
  final String? raliysiaAuth;
  const VoiceCallTimeScreenWidget(
      {Key? key,
      this.tokenId,
      this.channelName,
      this.callerAuthId,
      this.isVideoALL,
      @required this.transferId,
      this.raliysiaAuth})
      : super(key: key);

  @override
  State<VoiceCallTimeScreenWidget> createState() =>
      _VoiceCallTimeScreenWidgetState();
}

class _VoiceCallTimeScreenWidgetState extends State<VoiceCallTimeScreenWidget>
    with TickerProviderStateMixin {
  bool? isCallReceived;
  VoiceCallScreenController _voiceCallScreenController = Get.find();
  ScheduleViewModel _scheduleViewModel = Get.find();

  String appId = 'project id';

  BottomController _bottomController = Get.find();
  bool isCallCut = false;
  int levelClock = 180;
  bool isCallRecivedCheck = true;

  ///time
  final int timerMaxSeconds = 10;
  Timer? timer;
  String get timerText =>
      '${((timerMaxSeconds - _voiceCallScreenController.currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - _voiceCallScreenController.currentSeconds) % 60).toString().padLeft(2, '0')}';

  String formatDecimal(num value) => '$value'.padLeft(2, '0');

  String toMMSS(int value) =>
      '${formatDecimal(value ~/ 60)}:${formatDecimal(value % 60)}';
  String toMMSS1(int value) {
    _voiceCallScreenController.setCurrentSecondsForCall1(
        '${(double.parse(formatDecimal(value % 60)) * 100) / 60}');
    _voiceCallScreenController.setCurrentSecondsForCall2(
        (double.parse(_voiceCallScreenController.currentSecondsForCall1) / 100)
            .toString());
    print(
        '-------currentSecondsForCall1-------- ${double.parse(_voiceCallScreenController.currentSecondsForCall1) / 100}');
    // double m = double.parse(
    //     '0.${int.parse(_voiceCallScreenController.currentSecondsForCall1)}');
    // print('-----------------------doub--- $m');
    return '0.${formatDecimal(value % 60)}';
  }

  startTimeoutForCall([int? milliseconds]) {
    dynamic duration = interval;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      String minutesStr = (timer.tick % 60).toString();

      int minutes = (timer.tick / 60).truncate();
      double seconds = (timer.tick * 100) / 60;

      _voiceCallScreenController.setCurrentSeconds(timer.tick);
      _voiceCallScreenController.setCurrentSecondsForCall1(toMMSS1(timer.tick));
      _voiceCallScreenController.setCurrentSecondsForCall(toMMSS(timer.tick));
    });
  }

  ///aghora
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine? _engine;
  bool isChange = false;
  var endTime;
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          appId,
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine!.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    // configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine!.setVideoEncoderConfiguration(configuration);
    await _engine!.joinChannel(widget.tokenId, widget.channelName!, null, 0);
  }

  rtc.ClientRole _role = rtc.ClientRole.Broadcaster;

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(appId);
    await _engine!.enableVideo();
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine!.setClientRole(ClientRole.Broadcaster);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine!.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (_role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15), child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(height: Get.height, child: _videoView(views[0]));
      case 2:
        isChange = true;
        return Stack(
          children: <Widget>[
            Container(
                height: Get.height,
                width: Get.width,
                child: _videoView(views[1])),
            Positioned(
              // top: 20,
              right: 20,
              bottom: 90,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white)),
                  height: 200,
                  width: 150,
                  child: _videoView(views[0])),
            )
          ],
        );
      /*   case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));*/
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    if (_role == ClientRole.Audience) return Container();

    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.8),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: _onToggleMute,
                child: Icon(
                  isChange == true
                      ? Icons.video_call_outlined
                      : Icons.video_call,
                  color: Colors.white,
                  size: 25.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: isChange == true
                    ? Colors.blueAccent
                    : Colors.grey.withOpacity(0.5),
                //padding: const EdgeInsets.all(10.0),
              ),
              RawMaterialButton(
                  onPressed: () async {
                    _onCallEnd(context);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Container(
                        height: 41,
                        width: 41,
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 27.0,
                        ),
                      ),
                    ),
                  )),
              RawMaterialButton(
                onPressed: _onToggleMute,
                child: Icon(
                  muted ? Icons.mic : Icons.mic_off,
                  color: Colors.white,
                  size: 25.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor:
                    muted ? Colors.blueAccent : Colors.grey.withOpacity(0.5),
                //padding: const EdgeInsets.all(10.0),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 54),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 54),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///profile...

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine!.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine!.switchCamera();
  }

  bool
      //isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;

  /// permison
  _switchMicrophone() {
    _engine!.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine!.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      log('setEnableSpeakerphone $err');
    });
  }

  String isCallerName = '';
  String isImage = '';

  Future<bool> sendMoney() async {
    var headers = {
      'authToken': '${widget.raliysiaAuth}',
      'walletID': 'e10de1a0-a306-4d19-9d1f-21e8c5b0c323',
      //'${PreferenceManager.getWalletId()}',
      'Content-Type': 'application/json'
    };
    print('------transferId ----${widget.transferId}');
    var request =
        http.Request('POST', Uri.parse('https://api.relysia.com/v1/send'));
    request.body = json.encode({
      "dataArray": [
        {
          "to": widget.transferId,
          "amount": 0.000005,
          "type": "BSV",
          "notes": "from ${PreferenceManager.getNotSearchHandel()}",
          "tokenId": "string",
          "sn": 0
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await response.stream.bytesToString();

      return true;
    } else {
      FlutterRingtonePlayer.stop();
      _bottomController.isRingtone.value = false;

      if (_voiceCallScreenController.isAutoCut == false) {
        kFireStore
            .collection('UserAllData')
            .doc(PreferenceManager.getTokenId())
            .collection('callHistory')
            .add({
          'callerName': isCallerName,
          'startTime': _scheduleViewModel.dateTimeCall,
          'image': isImage,
          'endTime': DateTime.now(),
          'isVideoCall': _voiceCallScreenController.isVideo,
          'isReceivedCall': isCallReceived,
          'date_time': DateTime.now().toString()
        });
        String image = PreferenceManager.getImage();
        print('------PreferenceManager.getImage()--------$image');
        kFireStore
            .collection('UserAllData')
            .doc(widget.callerAuthId)
            .collection('callHistory')
            .add({
          'callerName': PreferenceManager.getFnameId(),
          'startTime': _scheduleViewModel.dateTimeCall,
          'image': image,
          'endTime': DateTime.now(),
          'isVideoCall': _voiceCallScreenController.isVideo,
          'isReceivedCall': isCallReceived,
          'date_time': DateTime.now().toString()
        });
        _voiceCallScreenController.isAutoCut = true;
      }
      if (_scheduleViewModel.isCallingMe == true) {
        FirebaseFirestore.instance
            .collection('UserAllData')
            .doc(PreferenceManager.getTokenId())
            .update({
          'isCalling': false,
          'isVideoCall': false,
          'isCallReceived': false,
          'caller_name': ''
        });

        FirebaseFirestore.instance
            .collection('UserAllData')
            .doc(widget.callerAuthId)
            .update({
          'isCalling': false,
          'isVideoCall': false,
          'isCallReceived': false,
        });
        _bottomController.isRingtone.value = false;
        _bottomController.isCallCutter.value = false;
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarScreen(),
          ));
      return false;

      print(response.reasonPhrase);
    }
  }

  getNameId() async {
    var snapshot = FirebaseFirestore.instance
        .collection("UserAllData")
        .doc(widget.callerAuthId);
    var querySnapshot = await snapshot.get();
    isCallerName = querySnapshot['name'];
    isImage = querySnapshot['isImage'];
    print('-----isImage----isImage----------$isImage');
    print('----querySnapshot[-----   ${querySnapshot['isImage']}');
  }

  String basicValue = '1';
  @override
  void initState() {
    initialize();
    getNameId();

    super.initState();
  }

  @override
  void dispose() {
    _users.clear();

    _engine!.leaveChannel();
    _engine!.destroy();
    timer!.cancel();
    print('dispose call');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceCallScreenController>(
      builder: (controller) => Material(
        color: ColorPicker.themBlackColor,
        child: Container(
          color: Color(0xff404040),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('UserAllData')
                .doc(PreferenceManager.getTokenId())
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              print(
                  '-----currentSecondsForCall------   ${controller.currentSecondsForCall.split(':').first}');

              if (_scheduleViewModel.isCallingMe == true) {
                if (controller.currentSecondsForCall != '') {
                  if (int.parse(
                              controller.currentSecondsForCall.split(':').first)
                          .toString() ==
                      basicValue) {
                    int m = int.parse(basicValue);
                    basicValue = '${++m}';
                    sendMoney();
                    print('----------m++ ${basicValue}');
                  }
                }
              }
              if (snapshot.hasData) {
                isCallReceived = snapshot.data['isCallReceived'];
                if (isCallRecivedCheck == false) {
                  if (isCallReceived == true) {
                    startTimeoutForCall();
                  }
                }
                // print('---daat-${snapshot.data['isCalling']}');

                if (isCallCut == false) {
                  if (snapshot.data['isCalling']) {
                  } else {
                    Future.delayed(Duration(seconds: 1), () {
                      FlutterRingtonePlayer.stop();
                      _bottomController.isRingtone.value = false;

                      if (controller.isAutoCut == false) {
                        kFireStore
                            .collection('UserAllData')
                            .doc(PreferenceManager.getTokenId())
                            .collection('callHistory')
                            .add({
                          'callerName': isCallerName,
                          'startTime': _scheduleViewModel.dateTimeCall,
                          'image': isImage,
                          'endTime': DateTime.now(),
                          'isVideoCall': controller.isVideo,
                          'isReceivedCall': isCallReceived,
                          'date_time': DateTime.now().toString()
                        });
                        String image = PreferenceManager.getImage();
                        print(
                            '------PreferenceManager.getImage()--------$image');
                        kFireStore
                            .collection('UserAllData')
                            .doc(widget.callerAuthId)
                            .collection('callHistory')
                            .add({
                          'callerName': PreferenceManager.getFnameId(),
                          'startTime': _scheduleViewModel.dateTimeCall,
                          'image': image,
                          'endTime': DateTime.now(),
                          'isVideoCall': controller.isVideo,
                          'isReceivedCall': isCallReceived,
                          'date_time': DateTime.now().toString()
                        });
                        controller.isAutoCut = true;
                      }

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationBarScreen(),
                          ));
                    });
                  }
                }
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  controller.isVideo
                      ? _viewRows()
                      : Container(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 160.sp,
                                padding: EdgeInsets.only(top: 100),
                                child: CommonWidget.svgPicture(
                                    image: 'assets/svg/person_user.svg'),
                              ),
                              CommonSizeBox.commonSizeBox(height: 10.sp),
                              CommonText.textSemiBoldP(text: isCallerName),
                              CommonSizeBox.commonSizeBox(height: 10.sp),
                              CommonText.textBold700P(
                                  text: controller.currentSecondsForCall),
                              CommonSizeBox.commonSizeBox(height: 6.sp),
                              CommonText.textMediumP(text: '\$2.40'),
                              // Countdown(
                              //   animation: StepTween(
                              //     begin: levelClock,
                              //     end: 0,
                              //   ).animate(_controller!),
                              // ),
                              // Countdown(
                              //   animation: StepTween(
                              //     begin: levelClock,
                              //     end: 0,
                              //   ).animate(_controller!),
                              // ),

                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: new LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 50,
                                  animation: true,
                                  barRadius: Radius.circular(20),
                                  animateFromLastPercent: true,
                                  lineHeight: 20.0,
                                  animationDuration: 1000,
                                  percent: double.parse(
                                      controller.currentSecondsForCall2),
                                  // center: Text("80.0%"),
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: ColorPicker.whiteColor,
                                  backgroundColor: Color(0xff9E9E9E),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff777794),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _switchSpeakerphone();
                          },
                          icon: CommonWidget.svgPicture(
                              image: enableSpeakerphone
                                  ? 'assets/svg/speckar.svg'
                                  : 'assets/svg/off_specker.svg'),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.setIsVideo();
                          },
                          icon: CommonWidget.svgPicture(
                              image: controller.isVideo
                                  ? 'assets/svg/vedio_call.svg'
                                  : 'assets/svg/di_video.svg'),
                        ),
                        IconButton(
                          onPressed: () {
                            _switchMicrophone();
                          },
                          icon: CommonWidget.svgPicture(
                              image: openMicrophone == false
                                  ? 'assets/svg/mute_icon.svg'
                                  : 'assets/svg/micro_phone.svg'),
                        ),
                        InkWell(
                          onTap: () async {
                            isCallCut = true;
                            controller.setCallCut();

                            if (_scheduleViewModel.isCallingMe == true) {
                              kFireStore
                                  .collection('UserAllData')
                                  .doc(PreferenceManager.getTokenId())
                                  .collection('callHistory')
                                  .add({
                                'callerName': isCallerName,
                                'startTime': _scheduleViewModel.dateTimeCall,
                                'image': isImage,
                                'endTime': DateTime.now(),
                                'isVideoCall': controller.isVideo,
                                'isReceivedCall': isCallReceived,
                                'date_time': DateTime.now().toString()
                              });
                              String image = PreferenceManager.getImage();
                              print(
                                  '------PreferenceManager.getImage()--------$isImage');
                              kFireStore
                                  .collection('UserAllData')
                                  .doc(widget.callerAuthId)
                                  .collection('callHistory')
                                  .add({
                                'callerName': PreferenceManager.getFnameId(),
                                'startTime': _scheduleViewModel.dateTimeCall,
                                'image': PreferenceManager.getImage(),
                                'endTime': DateTime.now(),
                                'isVideoCall': controller.isVideo,
                                'isReceivedCall': isCallReceived,
                                'date_time': DateTime.now().toString()
                              });
                            }
                            FirebaseFirestore.instance
                                .collection('UserAllData')
                                .doc(PreferenceManager.getTokenId())
                                .update({
                              'isCalling': false,
                              'isVideoCall': false,
                              'isCallReceived': false,
                              'caller_name': ''
                            });

                            FirebaseFirestore.instance
                                .collection('UserAllData')
                                .doc(widget.callerAuthId)
                                .update({
                              'isCalling': false,
                              'isVideoCall': false,
                              'isCallReceived': false,
                            });
                            _bottomController.isRingtone.value = false;
                            _bottomController.isCallCutter.value = false;

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationBarScreen(),
                                ));
                          },
                          child: Container(
                            height: 34.sp,
                            width: 34.sp,
                            child: SvgPicture.asset(
                              'assets/svg/call_cut_icon.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
