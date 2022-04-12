import 'package:get/get.dart';

class VoiceCallScreenController extends GetxController {
  bool isBottom = true;

  setIsBottom() {
    isBottom = !isBottom;
    update();
  }

  int currentSeconds = 0;

  setCurrentSeconds(int value) {
    currentSeconds = value;
    update();
  }

  String currentSecondsForCall = '';

  setCurrentSecondsForCall(String value) {
    currentSecondsForCall = value;
    update();
  }

  String currentSecondsForCall1 = '0.0';

  setCurrentSecondsForCall1(String value) {
    currentSecondsForCall1 = value;
    update();
  }

  String currentSecondsForCall2 = '0.0';

  setCurrentSecondsForCall2(String value) {
    currentSecondsForCall2 = value;
    update();
  }

  String _callerName = '';

  String get callerName => _callerName;

  set callerName(String value) {
    _callerName = value;
    update();
  }

  /// video on off
  bool isVideo = false;
  setTrueVideo({bool? isVideoCall}) {
    isVideo = isVideoCall!;
    update();
  }

  setIsVideo() {
    isVideo = !isVideo;
    update();
  }

  String _tokenID = '';

  String get tokenID => _tokenID;

  set tokenID(String value) {
    _tokenID = value;
    update();
  }

  String _channelId = '';

  String get channelId => _channelId;

  set channelId(String value) {
    _channelId = value;
    update();
  }

  String callerAuthToken = '';

  setCallerAuthToken({String? callerAuthTokenValue}) {
    callerAuthToken = callerAuthTokenValue!;
    update();
  }

  // setRingtone({bool? ringtone}) {
  //   isRingtone = ringtone.;
  //   update();
  // }
  ///call cut
  bool callCutBool = false;
  setCallCut() {
    callCutBool = true;
    update();
  }

  bool _isAutoCut = false;

  bool get isAutoCut => _isAutoCut;

  set isAutoCut(bool value) {
    _isAutoCut = value;
    update();
  }

  /// chat all id
  // final String? uid;
  // final String? email;
  // final String? fcmToken;
  // final String? image;

  String? _uid;

  String get uid => _uid!;

  set uid(String value) {
    _uid = value;
    update();
  }

  String? _email;

  String get email => _email!;

  set email(String value) {
    _email = value;
    update();
  }

  String? _fcmToken;

  String get fcmToken => _fcmToken!;

  set fcmToken(String value) {
    _fcmToken = value;
    update();
  }

  String? _image;

  String get image => _image!;

  set image(String value) {
    _image = value;
    update();
  }

  String? _transferId;

  String get transferId => _transferId!;

  set transferId(String value) {
    _transferId = value;
    update();
  }
}
