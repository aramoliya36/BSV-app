import 'dart:convert';
import 'dart:developer';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/calling_screen_controller.dart';
import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/delet_new_charge.dart';
import 'package:consultancy/model/repo/aghora_token_api.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/responseModel/agora_token_response.dart';
import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/model/services/app_notification.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/call/voice_call_time_page.dart';
import 'package:consultancy/view/chat/chatUi/rooms.dart';
import 'package:consultancy/view/scheduleScreens/schedule_meeting.dart';
import 'package:consultancy/view/searchScreen/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileNew extends StatefulWidget {
  const ProfileNew({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

String _selectedDate = '';
String _dateCount = '';
String _range = '';
String _rangeCount = '';

class _ProfileState extends State<ProfileNew> {
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;

  ScheduleViewModel _scheduleViewModel = Get.find();
  BottomController _bottomController = Get.find();
  bool isSelect = false;
  String date = '';
  String? year = '';
  final now = DateTime.now();
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  VoiceCallScreenController _voiceCallScreenController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ProgressHUD(
        child: Builder(
          builder: (context) {
            print(
                'payment_mode----  ${_scheduleViewModel.userData['payment_mode']}');
            return Scaffold(
              floatingActionButton: MaterialButton(
                onPressed: () {
                  _scheduleViewModel.datePicker = date;
                  print('-------------date--date----$date');
                  print(
                      '-------------date--date----${_scheduleViewModel.datePicker}');
                  if (date == '') {
                    CommonSnackBar.showSnackBar(msg: 'Please Select the date');
                  } else {
                    Get.to(ScheduleMeeting());
                  }
                },
                child: Container(
                  height: 50.sp,
                  child: CommonWidget.svgPicture(
                    image: 'assets/svg/right_arrow.svg',
                  ),
                ),
              ),
              backgroundColor: ColorPicker.themBlackColor,
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 36.sp,
                            child: CommonWidget.svgPicture(
                                image: 'assets/svg/user_profile_icon.svg'),
                          ),
                          Container(
                              height: 60.sp,
                              child: CommonWidget.svgPicture(
                                  image: 'assets/svg/app_icon.svg'))
                        ],
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 60.sp,
                          width: 60.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: _scheduleViewModel.imageUser == ''
                                ? SizedBox()
                                : Image.network(
                                    _scheduleViewModel.imageUser,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      Center(
                        child: CommonText.textBold700P(
                            text: _scheduleViewModel.userData['name'] ?? ''),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      Center(
                        child: Container(
                          // alignment: Alignment.center,
                          height: 30,
                          // /    width: 80,
                          decoration: BoxDecoration(
                              color: ColorPicker.greenButtonColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: CommonText.textSemiBoldDynamicP(
                                text:
                                    _scheduleViewModel.userData['user_name'] ??
                                        '',
                                fontSize: 9.sp,
                                textColor: ColorPicker.whiteColor),
                          ),
                        ),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Center(
                        child: CommonText.textSemiBoldP(
                            text: _scheduleViewModel.userData['Profession'] ??
                                ''),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      Container(
                        padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                        child: Center(
                          child: CommonText.textMediumP(
                            text:
                                _scheduleViewModel.userData['tell_us_about'] ??
                                    '',
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final progress = ProgressHUD.of(context);

                                  progress?.show();
                                  _bottomController.isRingtone.value = true;
                                  _voiceCallScreenController.setTrueVideo(
                                      isVideoCall: true);

                                  kFireStore
                                      .collection('UserAllData')
                                      .doc(PreferenceManager.getTokenId())
                                      .update({
                                    "isCalling": true,
                                    "isVideoCall": false,
                                    "caller_auth_token": _scheduleViewModel
                                        .userData['auth_Token']
                                  });
                                  _voiceCallScreenController.callerAuthToken =
                                      _scheduleViewModel.userData['auth_Token'];
                                  await _handleCameraAndMic(Permission.camera);
                                  await _handleCameraAndMic(
                                      Permission.microphone);
                                  AgoraTokenResponse _agoraTokenResponse =
                                      await AgoraTokenApiRepo
                                          .agoraTokenApiRepo();
                                  RelaysiaAuthResponse _res =
                                      await RegisterRelysiaRepo()
                                          .registerRelysiaRepo(
                                              isLogin: true,
                                              body: {
                                        'email': '',
                                        //'${PreferenceManager.getTokenId()}@gmail.com',
                                        'password': ''
                                        //PreferenceManager.getTokenId()
                                      });
                                  sendMoney(
                                      raliysiaAuth: _res.data!.token,
                                      transferId: _scheduleViewModel
                                          .userData['transaction_id']);
                                  print(
                                      '------_res.data.token m------${_res.data!.token}');
                                  kFireStore
                                      .collection('UserAllData')
                                      .doc(_scheduleViewModel
                                          .userData['auth_Token'])
                                      .update({
                                    "isCalling": true,
                                    "isVideoCall": false,
                                    "isCallReceived": false,
                                    "caller_name":
                                        PreferenceManager.getFnameId(),
                                    "agora_token":
                                        _agoraTokenResponse.tokenUId!,
                                    "agora_channel_name":
                                        _agoraTokenResponse.channelName!,
                                    "caller_auth_token":
                                        PreferenceManager.getTokenId()
                                  });
                                  _voiceCallScreenController.callerName =
                                      _scheduleViewModel.userData['name'];

                                  AppNotificationHandler.sendMessage(
                                      isRing: true,
                                      receiverFcmToken: _scheduleViewModel
                                          .userData['fcm_token'],
                                      msg:
                                          'calling ${PreferenceManager.getFnameId()}');
                                  _scheduleViewModel.dateTimeCall =
                                      DateTime.now();
                                  _scheduleViewModel.isCallingMe = true;
                                  print(
                                      'transaction_idtransaction_idtransaction_id- ${_scheduleViewModel.userData['transaction_id']}');
                                  progress!.dismiss();

                                  Get.to(() => VoiceCallTimeScreenWidget(
                                        raliysiaAuth: _res.data!.token,
                                        transferId: _scheduleViewModel
                                            .userData['transaction_id'],
                                        isVideoALL:
                                            _voiceCallScreenController.isVideo,
                                        channelName:
                                            _agoraTokenResponse.channelName!,
                                        tokenId: _agoraTokenResponse.tokenUId!,
                                        callerAuthId: _scheduleViewModel
                                            .userData['auth_Token'],
                                      ));
                                },
                                child: CommonWidget.svgPicture(
                                    image: 'assets/svg/call_bold_icon.svg'),
                              ),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .01),
                              CommonText.textBold700P(
                                  text:
                                      '${_scheduleViewModel.userData['price_audio']}  ${_scheduleViewModel.userData['payment_mode'] == 'BitcoinSV' ? 'BSV' : _scheduleViewModel.userData['payment_mode'] == 'Pound Sterling (GBP)' ? '£' : '£'}'),
                              // _scheduleViewModel
                              //     .userData['price_audio']),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .01),
                              CommonText.textSemiBoldDynamicP(
                                  text: 'Per Minute',
                                  fontSize: 10.sp,
                                  textColor: Colors.white)
                            ],
                          ),
                          CommonWidget.svgPicture(
                              image: 'assets/svg/vertical_de.svg'),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final progress = ProgressHUD.of(context);

                                  progress?.show();
                                  _bottomController.isRingtone.value = true;
                                  _voiceCallScreenController.setTrueVideo(
                                      isVideoCall: true);

                                  kFireStore
                                      .collection('UserAllData')
                                      .doc(PreferenceManager.getTokenId())
                                      .update({
                                    "isCalling": true,
                                    "isVideoCall": true,
                                    "caller_auth_token": _scheduleViewModel
                                        .userData['auth_Token']
                                  });
                                  _voiceCallScreenController.callerAuthToken =
                                      _scheduleViewModel.userData['auth_Token'];
                                  await _handleCameraAndMic(Permission.camera);
                                  await _handleCameraAndMic(
                                      Permission.microphone);
                                  AgoraTokenResponse _agoraTokenResponse =
                                      await AgoraTokenApiRepo
                                          .agoraTokenApiRepo();
                                  RelaysiaAuthResponse _res =
                                      await RegisterRelysiaRepo()
                                          .registerRelysiaRepo(
                                              isLogin: true,
                                              body: {
                                        'email': '',
                                        'password': '123456'
                                      });
                                  sendMoney(
                                      raliysiaAuth: _res.data!.token,
                                      transferId: _scheduleViewModel
                                          .userData['transaction_id']);
                                  print(
                                      '------_res.data.token m------${_res.data!.token}');

                                  kFireStore
                                      .collection('UserAllData')
                                      .doc(_scheduleViewModel
                                          .userData['auth_Token'])
                                      .update({
                                    "isCalling": true,
                                    "isVideoCall": true,
                                    "isCallReceived": false,
                                    "caller_name":
                                        PreferenceManager.getFnameId(),
                                    "agora_token":
                                        _agoraTokenResponse.tokenUId!,
                                    "agora_channel_name":
                                        _agoraTokenResponse.channelName!,
                                    "caller_auth_token":
                                        PreferenceManager.getTokenId()
                                  });
                                  _voiceCallScreenController.callerName =
                                      _scheduleViewModel.userData['name'];
                                  AppNotificationHandler.sendMessage(
                                      isRing: true,
                                      receiverFcmToken: _scheduleViewModel
                                          .userData['fcm_token'],
                                      msg:
                                          'calling ${PreferenceManager.getFnameId()}');
                                  _scheduleViewModel.dateTimeCall =
                                      DateTime.now();
                                  _scheduleViewModel.isCallingMe = true;
                                  progress!.dismiss();

                                  Get.to(() => VoiceCallTimeScreenWidget(
                                        raliysiaAuth: _res.data!.token,
                                        transferId: _scheduleViewModel
                                            .userData['transaction_id'],
                                        isVideoALL: true,
                                        channelName:
                                            _agoraTokenResponse.channelName!,
                                        tokenId: _agoraTokenResponse.tokenUId!,
                                        callerAuthId: _scheduleViewModel
                                            .userData['auth_Token'],
                                      ));
                                },
                                child: CommonWidget.svgPicture(
                                    image: 'assets/svg/video_icon.svg'),
                              ),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .01),
                              CommonText.textBold700P(
                                  text:
                                      '${_scheduleViewModel.userData['price_video']}  ${_scheduleViewModel.userData['payment_mode'] == 'BitcoinSV' ? 'BSV' : _scheduleViewModel.userData['payment_mode'] == 'Pound Sterling (GBP)' ? '£' : '£'}'),
                              // _scheduleViewModel
                              //     .userData['price_video']),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .01),
                              CommonText.textSemiBoldDynamicP(
                                  text: 'Per Minute',
                                  fontSize: 10.sp,
                                  textColor: Colors.white)
                            ],
                          ),
                          CommonWidget.svgPicture(
                              image: 'assets/svg/vertical_de.svg'),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  FirebaseFirestore.instance
                                      .collection('chat')
                                      .doc(
                                          '${PreferenceManager.getTokenId()}-${_scheduleViewModel.userData['auth_Token']}')
                                      .set({
                                    'name': PreferenceManager.getFnameId(),
                                    'name1':
                                        _scheduleViewModel.userData['name'],
                                    'userImage': PreferenceManager.getImage(),
                                    'userImage1': _scheduleViewModel
                                        .userData['userImage'],
                                    'transaction_id': _scheduleViewModel
                                        .userData['transaction_id'],
                                    'transaction_id1':
                                        PreferenceManager.getTransferId(),
                                    'auth_Token':
                                        PreferenceManager.getTokenId(),
                                    "auth_Token1": _scheduleViewModel
                                        .userData['auth_Token'],
                                  });
                                  _voiceCallScreenController.fcmToken =
                                      _scheduleViewModel.userData['fcm_token'];
                                  _voiceCallScreenController.uid =
                                      _scheduleViewModel.userData['auth_Token'];
                                  _voiceCallScreenController.email =
                                      _scheduleViewModel.userData['name'];
                                  _voiceCallScreenController.image =
                                      _scheduleViewModel.userData['userImage'];
                                  _voiceCallScreenController.transferId =
                                      _scheduleViewModel
                                          .userData['transaction_id'];
                                  _bottomController.bottomIndex.value = 3;
                                  _bottomController.selectedScreen('ChatRoom');
                                  // Get.to(ChatRoom(
                                  //   image: _scheduleViewModel.userData['userImage'],
                                  //   fcmToken:
                                  //       _scheduleViewModel.userData['fcm_token'],
                                  //   email: _scheduleViewModel.userData['name'],
                                  //   uid: _scheduleViewModel.userData['auth_Token'],
                                  // ));
                                },
                                child: CommonWidget.svgPicture(
                                    image: 'assets/svg/message_icon_bold.svg'),
                              ),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .02),
                              CommonText.textBold700P(
                                  text:
                                      '${_scheduleViewModel.userData['price_message']}  ${_scheduleViewModel.userData['payment_mode'] == 'BitcoinSV' ? 'BSV' : _scheduleViewModel.userData['payment_mode'] == 'Pound Sterling (GBP)' ? '£' : '£'}'),
                              CommonSizeBox.commonSizeBox(
                                  height: Get.height * .01),
                              CommonText.textSemiBoldDynamicP(
                                  text: 'Per Minute',
                                  fontSize: 10.sp,
                                  textColor: Colors.white),
                            ],
                          ),
                        ],
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .03),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: CommonWidget.svgPicture(
                              image: 'assets/svg/absolute.svg',
                            ),
                          ),
                          CommonSizeBox.commonSizeBox(width: Get.height * .01),
                          CommonText.textSemiBoldDynamicP(
                              text: 'Call Limit : 30 minutes',
                              fontSize: 8.sp,
                              textColor: Colors.white),
                        ],
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .04),
                      TextButton.icon(
                        onPressed: () {
                          print('Button pressed');
                          setState(() {
                            if (isSelect == false) {
                              isSelect = true;
                            } else {
                              isSelect = false;
                            }
                          });
                        },
                        icon: Container(
                          height: 16.sp,
                          child: CommonWidget.svgPicture(
                            image: 'assets/svg/calender.svg',
                          ),
                        ),
                        label: CommonText.textSemiBoldDynamicP(
                            text: 'SCHEDULE A MEETING',
                            fontSize: 12.sp,
                            textColor: Colors.white),
                      ),
                      CommonSizeBox.commonSizeBox(height: Get.height * .04),
                      isSelect == false
                          ? SizedBox()
                          : Container(
                              color: Colors.transparent,
                              child: SfDateRangePicker(
                                onViewChanged:
                                    (dateRangePickerViewChangedArgs) {
                                  print(
                                      '---------p0---------${dateRangePickerViewChangedArgs.view.index}');
                                },
                                onSubmit: (p0) {
                                  print('---------p0---------$p0');
                                },
                                headerStyle: DateRangePickerHeaderStyle(
                                    textStyle: CommonText
                                        .textStyleSemiBold600Normal()),
                                todayHighlightColor: ColorPicker.whiteColor,
                                yearCellStyle: DateRangePickerYearCellStyle(
                                    textStyle: TextStyle(
                                        color: ColorPicker.whiteColor)),
                                monthCellStyle: DateRangePickerMonthCellStyle(
                                    textStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff838393))),
                                backgroundColor: Colors.transparent,
                                enablePastDates: false,
                                onSelectionChanged: _onSelectionChanged,
                                view: DateRangePickerView.month,
                                minDate:
                                    DateTime(now.year, now.month, now.day + 1),
                                monthViewSettings:
                                    DateRangePickerMonthViewSettings(
                                        firstDayOfWeek: 1,
                                        viewHeaderStyle:
                                            DateRangePickerViewHeaderStyle(
                                                textStyle: CommonText
                                                    .textStyleSemiBold600Normal()),
                                        weekNumberStyle:
                                            DateRangePickerWeekNumberStyle(
                                          backgroundColor:
                                              ColorPicker.whiteColor,
                                          textStyle: CommonText
                                              .textStyleSemiBold600Normal(),
                                        )),
                              ),
                            ),
                      // Text(
                      //   date!,
                      //   style: TextStyle(color: Colors.white),
                      // )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      onWillPop: () {
        _bottomController.bottomIndex.value = 3;
        _bottomController.selectedScreen('SearchScreen');

        return Future.value(false);
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        String new_date = DateFormat('yyyy').format(args.value);
        String datetime3 = DateFormat.MMMMEEEEd().format(args.value);
        date = datetime3;
        year = new_date;
        print(new_date);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        // print(_dateCount);
      } else {
        _rangeCount = args.value.length.toString();
        // print(_rangeCount);
      }
    });
  }

  sendMoney({String? raliysiaAuth, String? transferId}) async {
    var headers = {
      'authToken': '',
      'walletID': '',
      //'${PreferenceManager.getWalletId()}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse(''));
    request.body = json.encode({
      "dataArray": [
        {
          "to": transferId,
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
      print(await response.stream.bytesToString());
      print('----------call sucesssss');
    } else {
      print(response.reasonPhrase);
    }
  }
}
