import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/calling_screen_controller.dart';
import 'package:consultancy/ViewModel/get_wallet_id_viewmodel.dart';
import 'package:consultancy/ViewModel/register_relysia_viewmodel.dart';
import 'package:consultancy/ViewModel/send_money_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_drawer.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/repo/send_money_repo.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:consultancy/model/requestModel/send_money_req_model.dart';
import 'package:consultancy/model/responseModel/get_wallet_id.dart';
import 'package:consultancy/model/services/google_sign_in.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/chat/chatUi/rooms.dart';
import 'package:consultancy/view/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key}) : super(key: key);

  @override
  State<UserHomeWidget> createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  BottomController _bottomController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VoiceCallScreenController _voiceCallScreenController = Get.find();
  List<User> _searchList = [];
  Map<String, dynamic>? _userMap;
  ChatUserList? _chatUserList;
  RegisterRelasiyaReqModel _registerRelasiyaReqModel =
      RegisterRelasiyaReqModel();
  AddToCartViewModel _addToCartViewModel = Get.put(AddToCartViewModel());

  sendMoney() async {
    var headers = {
      'authToken':
          'eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ2NDExN2FjMzk2YmM3MWM4YzU5ZmI1MTlmMDEzZTJiNWJiNmM2ZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaGl2ZWRiLWNkYmY3IiwiYXVkIjoiaGl2ZWRiLWNkYmY3IiwiYXV0aF90aW1lIjoxNjQ4ODg3NzU5LCJ1c2VyX2lkIjoiOEJRTTIyN3dJc2RUbklQVU9VdzhuMFpPY1l4MSIsInN1YiI6IjhCUU0yMjd3SXNkVG5JUFVPVXc4bjBaT2NZeDEiLCJpYXQiOjE2NDg4ODc3NTksImV4cCI6MTY0ODg5MTM1OSwiZW1haWwiOiJkYW1jb2RlMTk5MEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJkYW1jb2RlMTk5MEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.fUUJJHBIuqauQJ5etyh4aAffW73n31hwgx5ukhzT0V0v0htNemYuj7iq0rpp5i03DcIOpdO4Zai1eTEsD9nt5NBnthMleN_hKLdxZ2p4q_ZXb80DocMraXJcQMaft59G1NHesG3VE81sLvHKFEm4ydnCYW5_6VK6wZtS2rTl3Glo63e4Ld4MER5BVu6udLgeTfu1wddY5HHEdVjN3Oj-P5-v1MWN4vPrNbtovqM20gq5ba5ZsgQ_EhInwWvWMhrnDRlTKUXCV0E6qH-FZbl4SANkQggTymqfU45WWmUsKNXf1OWeTh-SvpKGJXKi2ifDJH5tk6jp6fmsFqNvm0Fo9Q',
      'walletID': 'e10de1a0-a306-4d19-9d1f-21e8c5b0c323',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('https://api.relysia.com/v1/send'));
    request.body = json.encode({
      "dataArray": [
        {
          "to": "17n2JVhrCf1oYSMkZtZNjcf1deteUEKQsH",
          "amount": 0.000005,
          "type": "BSV",
          "notes": "string",
          "tokenId": "string",
          "sn": 0
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  GetWalletIdViewModel _getWalletIdViewModel = Get.find();
  bool _searchClicked = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(
        '----- PreferenceManager.getImage()   ${PreferenceManager.getImage().runtimeType}');
    return Scaffold(
      key: _scaffoldKey,
      drawer: CommonDrawer.commonDrawer(context: context),
      backgroundColor: ColorPicker.themBlackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: Column(
              children: [
                //first blog
                Container(
                  //  color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Stack(
                          children: [
                            Container(
                              child: PreferenceManager.getImage() == null ||
                                      PreferenceManager.getImage() == ''
                                  ? SizedBox()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        PreferenceManager.getImage(),
                                        fit: BoxFit.cover,
                                      )),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              height: 34.sp,
                              width: 34.sp,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 12.sp,
                                width: 12.sp,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorPicker.whiteColor,
                                        width: 2),
                                    shape: BoxShape.circle,
                                    color: ColorPicker.greenIndicatorColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       _scaffoldKey.currentState!.openDrawer();
                      //     },
                      //     icon: Icon(
                      //       Icons.dehaze_rounded,
                      //       color: Colors.white,
                      //     )),
                      CommonSizeBox.commonSizeBox(width: 10.sp),

                      // Column(
                      //   children: [
                      //     CommonSizeBox.commonSizeBox(height: 20.sp),
                      //     Container(
                      //       width: 12.sp,
                      //       height: 12.sp,
                      //       // color: Color(0xffDCA8C),
                      //       decoration: BoxDecoration(
                      //           color: ColorPicker.greenIndicatorColor,
                      //           border: Border.all(color: Colors.white),
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(20))),
                      //     ),
                      //   ],
                      // ),
                      Spacer(),
                      // CommonSizeBox.commonSizeBox(width: 20.sp),
                      CommonText.textBold700PDynamicP(
                          text: 'CHATS',
                          textColor: ColorPicker.whiteColor,
                          fontSize: 18.sp),
                      // SvgPicture.asset('assets/svg/app_icon.svg'),
                      Spacer(),

                      CommonSizeBox.commonSizeBox(width: 20.sp),
                      InkWell(
                          onTap: () {
                            _bottomController.bottomIndex.value = 3;
                            _bottomController
                                .setSelectedScreen('NewChatScreen');
                          },
                          child:
                              SvgPicture.asset('assets/svg/message_icon.svg')),
                    ],
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: 8),
                InkWell(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);

                    //  Get.to(SearchScreen());
                    _bottomController.setSelectedScreen('SearchScreen');
                    _bottomController.bottomIndex.value = 3;
                  },
                  child: Container(
                    width: double.infinity,
                    height: 30.sp,
                    decoration: BoxDecoration(
                      color: ColorPicker.searchBarColor,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonSizeBox.commonSizeBox(width: 10.sp),
                        Icon(
                          Icons.search,
                          color: ColorPicker.whiteColor,
                        ),
                        CommonText.textMediumDynamicColorP(
                            text: 'Search', textColor: ColorPicker.whiteColor)
                      ],
                    ),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: 14.sp),
                // InkWell(
                //   onTap: () async {
                //     // Map<String, String> header = {
                //     //   "authToken":
                //     //       "eyJhbGciOiJSUzI1NiIsImtpZCI6IjQ2NDExN2FjMzk2YmM3MWM4YzU5ZmI1MTlmMDEzZTJiNWJiNmM2ZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vaGl2ZWRiLWNkYmY3IiwiYXVkIjoiaGl2ZWRiLWNkYmY3IiwiYXV0aF90aW1lIjoxNjQ4NzIzMzQxLCJ1c2VyX2lkIjoiOEJRTTIyN3dJc2RUbklQVU9VdzhuMFpPY1l4MSIsInN1YiI6IjhCUU0yMjd3SXNkVG5JUFVPVXc4bjBaT2NZeDEiLCJpYXQiOjE2NDg3MjMzNDEsImV4cCI6MTY0ODcyNjk0MSwiZW1haWwiOiJkYW1jb2RlMTk5MEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJkYW1jb2RlMTk5MEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.AcigCn7-ikGerAAt0KR9BCfA7H5lJVFgTpNGPXbBwdVLeOb8LWp8mVKOxTRymYp98sX36aZ43Vadp7wWkFurrcRvqJg68Kwdt5jIvF33NIyjDiGpV-dLYugU3MsHnoyw7yy3u-OtJwsn1RH-DepocoWZq9csT4aL8U9I__HOGQht6m5UsCm6alyiu_CgdDloiYgpityI2yKUIlGWxX3tgv24JmOddTjoMS6KkKLc58zXheceRzTRxaikIMf47qBAbFA4aL9ih-xEVBSiaOgF305Ppehek8vDvqW7avvYNY3T2QU2K6RvFbJ_KbVx4Z_XN7f3CXGeJJHGkas_bfcJ3w"
                //     // };
                //     // await _getWalletIdViewModel.getWalletIdViewModel(
                //     //     header: header);
                //     // GetWalletIdResponse res =
                //     //     _getWalletIdViewModel.apiResponse.data;
                //     // print(
                //     //     '------wallets-----  ${res.data!.wallets![0].walletId}');
                //
                //     ///
                //     //CRDiYNuNVKMdbJJNCyiBZHVv4ss1
                //     // _registerRelasiyaReqModel.emailOrPhone =
                //     //     '';
                //     //  'CRDiYNuNVKMdbJJNCyiBZHVv4ss1@gmail.com';
                //     // _registerRelasiyaReqModel.password = '123456';
                //
                //     // 'CRDiYNuNVKMdbJJNCyiBZHVv4ss1';
                //     // RegisterRelysiaRepo().registerRelysiaRepo(
                //     //     isLogin: true,
                //     //     body: _registerRelasiyaReqModel.toJson());
                //     // FlutterRingtonePlayer.stop();
                //     sendMoney();
                //     print('ringggg');
                //     // PreferenceManager.getStorage.erase();
                //     // AgoraTokenApiRepo.agoraTokenApiRepo();
                //   },
                //   child: Text(
                //     'Clear all data',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CHATS',
                    style: CommonText.textStyleSemiBold700(),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: 13.sp),

                StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('chat').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var _userData = snapshot.data!.docs[index];
                          // PreferenceManager
                          if ((_userData['auth_Token'] ==
                                  PreferenceManager.getTokenId() ||
                              _userData['auth_Token1'] ==
                                  PreferenceManager.getTokenId())) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  var collection = FirebaseFirestore.instance
                                      .collection('UserAllData')
                                      .doc(_userData['auth_Token'] ==
                                              PreferenceManager.getTokenId()
                                          ? _userData['auth_Token1']
                                          : _userData['auth_Token']);
                                  var querySnapshot = await collection.get();

                                  _voiceCallScreenController.image =
                                      PreferenceManager.getImage() ==
                                              _userData['userImage']
                                          ? _userData['userImage1']
                                          : _userData['userImage'];
                                  _voiceCallScreenController.uid =
                                      _userData['auth_Token'] ==
                                              PreferenceManager.getTokenId()
                                          ? _userData['auth_Token1']
                                          : _userData['auth_Token'];
                                  _voiceCallScreenController.email =
                                      PreferenceManager.getFnameId() ==
                                              _userData['name']
                                          ? _userData['name1']
                                          : _userData['name'];
                                  _voiceCallScreenController.fcmToken =
                                      querySnapshot['fcm_token'] ?? '';
                                  _bottomController.bottomIndex.value = 3;
                                  _bottomController.selectedScreen('ChatRoom');
                                  // Get.to(ChatRoom(
                                  //   image: PreferenceManager.getImage() ==
                                  //           _userData['userImage']
                                  //       ? _userData['userImage1']
                                  //       : _userData['userImage'],
                                  //   fcmToken: querySnapshot['fcm_token'] ?? '',
                                  //   email: PreferenceManager.getFnameId() ==
                                  //           _userData['name']
                                  //       ? _userData['name1']
                                  //       : _userData['name'],
                                  //   uid: _userData['auth_Token'] ==
                                  //           PreferenceManager.getTokenId()
                                  //       ? _userData['auth_Token1']
                                  //       : _userData['auth_Token'],
                                  // ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 36.sp,
                                      width: 36.sp,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: _userData['name1'] ==
                                                    '+App Admin' ||
                                                _userData['name'] ==
                                                    '+App Admin'
                                            ? SizedBox()
                                            : _userData['userImage'] == null ||
                                                    _userData['userImage1'] ==
                                                        null
                                                ? SizedBox()
                                                : Image.network(
                                                    PreferenceManager
                                                                .getImage() ==
                                                            _userData[
                                                                'userImage']
                                                        ? _userData[
                                                            'userImage1']
                                                        : _userData[
                                                            'userImage'],
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: ColorPicker.searchBarColor,
                                          shape: BoxShape.circle),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CommonText.textMediumP(
                                          text:
                                              PreferenceManager.getFnameId() ==
                                                      _userData['name']
                                                  ? _userData['name1']
                                                  : _userData['name']),
                                      // child: Text(
                                      //     PreferenceManager.getFnameId() ==
                                      //             _userData['name']
                                      //         ? _userData['name1']
                                      //         : _userData['name']),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ChatUserList> fetchAllUser() async {
    var users;

    users = await FirebaseFirestore.instance.collection('UserAllData').get();

    _chatUserList =
        ChatUserList.fromJson(users.docs.map((e) => e.data()).toList());
    return _chatUserList!;
  }

  int findSpecificUser(String query) {
    // ChatUserList _queryList = _chatUserList;
    _searchList.clear();
    if (query != null) {
      _chatUserList!.users.forEach((element) {
        if (element.name!.toLowerCase().contains(query.toLowerCase())) {
          print("matched");
          _searchList.add(element);
        }
      });
    }
    return _searchList == null ? 0 : _searchList.length;
  }
}

class User {
  String? name;
  String? profile;
  String? uid;
  String? schoolUrl;
  String? role;
  User(
      {@required this.name,
      @required this.profile,
      @required this.uid,
      @required this.schoolUrl,
      @required this.role});

  factory User.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String; // cast as non-nullable String
    final profile = data['profile'] as String; // cast as non-nullable String
    final uid = data['uid'] as String; // cast as non-nullable String
    final schoolUrl =
        data['school_url'] as String; // cast as non-nullable String
    final role = data['role'] as String; // cast as non-nullable String
    return User(
        name: name,
        profile: profile,
        uid: uid,
        role: role,
        schoolUrl: schoolUrl);
  }

  Map<String, dynamic> toJson() {
    // return a map literal with all the non-null key-value pairs
    return {
      'name': name,
      'profile': profile,
      'uid': uid,
      'school_url': schoolUrl,
      'role': role,
    };
  }
}

class ChatUserList {
  List<User> users;

  ChatUserList(this.users);

  factory ChatUserList.fromJson(List<dynamic> json) {
    List<User> chatUserList = [];

    chatUserList = json.map((i) => User.fromJson(i)).toList();
    return ChatUserList(chatUserList);
  }
}
