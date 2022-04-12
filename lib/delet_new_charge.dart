import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart' as rtc;
import 'package:permission_handler/permission_handler.dart';

import 'common/preference_manager.dart';

// 86542bf2e24b4b878cfb2a622ba7635c
String appId = '86542bf2e24b4b878cfb2a622ba7635c';
String tokenId =
    '00686542bf2e24b4b878cfb2a622ba7635cIADaLYVPOcvZcsjMrMX9WOueYquJy/Q5rCvzFDT3xwTY04RP6EgAAAAAEADjTvSO77gxYgEAAQDvuDFi';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  // final String? channelName;
  // final String? userId;
  // final String? img;
  // final String? imgurl;
  // final String? name;
  // final int? age;
  // DateTime? startDate;
  // String? callType;
  // String? username;

  /// non-modifiable client role of the page

  /// Creates a call page with given channel name.
  CallPage({
    Key? key,
  }) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
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

  BottomController _bottomController = Get.find();
  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine!.leaveChannel();
    _engine!.destroy();
    super.dispose();
  }

  m() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    //m();
    initialize();
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
    await _engine!.joinChannel(tokenId, 'plusApp', null, 0);
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
              top: 20,
              right: 20,
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

  @override
  Widget build(BuildContext context) {
    print('-----------role--- $_role');

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('UserAllData')
                .doc(PreferenceManager.getTokenId())
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print('---daat-${snapshot.data['isCalling']}');

                if (snapshot.data['isCalling'] == false) {
                  //  Get.to(ProfileScreenPage());

                }
              }
              return Stack(
                children: <Widget>[
                  _viewRows(),
                  // _panel(),
                  _toolbar(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
