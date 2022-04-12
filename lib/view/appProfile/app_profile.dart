import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/Res/Text/text_common.dart';
import 'package:consultancy/ViewModel/app_profile_controller.dart';
import 'package:consultancy/ViewModel/create_wallet_viewmodel.dart';
import 'package:consultancy/ViewModel/get_address_id_tra_viewmodel.dart';
import 'package:consultancy/ViewModel/get_wallet_id_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:consultancy/model/requestModel/user_data_req.dart';
import 'package:consultancy/model/responseModel/create_wallet_response.dart';
import 'package:consultancy/model/responseModel/get_address_id_responsemodle.dart';
import 'package:consultancy/model/responseModel/get_wallet_id.dart';
import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/view/bottombar/navigation_bar.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppProfile extends StatefulWidget {
  // const AppProfile({Key key}) : super(key: key);

  @override
  _AppProfileState createState() => _AppProfileState();
}

class _AppProfileState extends State<AppProfile> {
  int id = 1;
  String radioItem = "+Yes ";
  String? _radioValue = "Yes";
  String? choice;
  String? gender;
  String? getHandelName;
  String? downloadUrl;
  AppProfileController _appProfileController = Get.find();

  CreateWalletViewModel _createWalletViewModel = Get.find();
  GetAddressIdTraViewModel _addressIdTraViewModel = Get.find();
  GetWalletIdViewModel _getWalletIdViewModel = Get.find();
  UserAllDataRequest _userData = UserAllDataRequest();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _tellUsController = TextEditingController();
  final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  BottomController _bottomController = Get.find();
  RegisterRelasiyaReqModel _user = RegisterRelasiyaReqModel();
  bool isHandel = true;
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _userNameController.dispose();
    _professionController.dispose();
    _tellUsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: Builder(
      builder: (context) => Scaffold(
        backgroundColor: ColorPicker.themBlackColor,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 4.h),
          child: CommonButton.commonSignButtonWithoutIcon(
              name: 'COMPLETE',
              onTap: () async {
                if (_nameController.text.isNotEmpty) {
                  if (_userNameController.text.isNotEmpty) {
                    final progress = ProgressHUD.of(context);

                    progress?.show();

                    await uploadImgFirebaseStorage(
                        file: _appProfileController.profileImage,
                        progress: progress);

                    progress!.dismiss();
                  } else {
                    CommonSnackBar.showSnackBar(
                        successStatus: false, msg: 'Please enter username');
                  }
                } else {
                  CommonSnackBar.showSnackBar(
                      successStatus: false, msg: 'Please enter name');
                }
              }),
        ),
        appBar: CommonWidget.appBarWithTitle(title: 'Profile Essentials'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonSizeBox.commonSizeBox(height: Get.height / 16),
                    Stack(
                      children: [
                        GetBuilder<AppProfileController>(
                          builder: (controller) {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 90.sp,
                                width: 90.sp,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0XFFC4C4C4)),
                                child: controller.profileImage != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(90.sp),
                                        child: Image.file(
                                            controller.profileImage!,
                                            fit: BoxFit.cover),
                                      )
                                    : SizedBox(),
                              ),
                            );
                          },
                        ),
                        Positioned(
                            bottom: 0,
                            right: 76.sp,
                            child: InkWell(
                              onTap: () {
                                buttonChangeProfile();
                              },
                              child: Container(
                                height: 36.sp,
                                width: 36.sp,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPicker.whiteColor),
                                child: Padding(
                                  padding: EdgeInsets.all(12.sp),
                                  child:
                                      SvgPicture.asset('assets/svg/pan_b.svg'),
                                ),
                              ),
                            ))
                      ],
                    ),
                    CommonSizeBox.commonSizeBox(height: 2.h),
                    Column(
                      children: [
                        CommonTextFiled.commonTextFiled(
                            hintText: 'Name', controller: _nameController),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: ColorPicker.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          onChanged: (v) {},
                          controller: _userNameController,
                          cursorColor: ColorPicker.whiteColor,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.add, color: Colors.white, size: 14),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            hintText: 'Handle (Username)',
                            contentPadding: EdgeInsets.all(10.sp),
                            hintStyle: TextStyle(
                                color: ColorPicker.hintTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: ColorPicker.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          onChanged: (v) {},
                          controller: _professionController,
                          cursorColor: ColorPicker.whiteColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            hintText: 'Profession',
                            contentPadding: EdgeInsets.all(10.sp),
                            hintStyle: TextStyle(
                                color: ColorPicker.hintTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: ColorPicker.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          onChanged: (v) {},
                          controller: _tellUsController,
                          cursorColor: ColorPicker.whiteColor,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            hintText: 'Tell us about yourself?',
                            contentPadding: EdgeInsets.all(10.sp),
                            hintStyle: TextStyle(
                                color: ColorPicker.hintTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  color: ColorPicker.hintTextColor, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    CommonText.textMediumP(
                        text:
                            'Do you want to set up a public charge per \nminute for your +Handle now?'),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          buildRow(
                              value: "Yes",
                              title: "Yes",
                              onChanged: () {
                                return radioButtonChanges('Yes');
                              }),
                          CommonSizeBox.commonSizeBox(width: 60.sp),
                          buildRow(
                              value: "Maybe Later ",
                              title: "Maybe Later ",
                              onChanged: () {
                                return radioButtonChanges('Maybe Later ');
                              }),
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: 20.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildRow({String? value, String? title, dynamic onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        children: [
          InkWell(
            onTap: onChanged,
            child: Container(
              height: 15.sp,
              width: 15.sp,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 10.sp,
                  width: 10.sp,
                  decoration: BoxDecoration(
                      color: _radioValue == value ? Colors.black : Colors.white,
                      shape: BoxShape.circle),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
            ),
          ),
          CommonSizeBox.commonSizeBox(width: 16.sp),
          CommonText.textMediumDynamicColorP(
              text: title!, textColor: ColorPicker.whiteColor, textSize: 12.sp),
        ],
      ),
    );
  }

  radioButtonChanges(value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '+Yes ':
          choice = value;
          break;

        case 'Maybe Later ':
          choice = value;
          break;
        default:
          choice = '';
      }
      debugPrint(choice);
      gender = choice;
      //Debug the choice in console
    });
  }

  buttonChangeProfile() {
    Get.dialog(Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: Get.height * 0.2,
          width: Get.width * 0.5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorPicker.buttonColor)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    _appProfileController.getGalleryImage().then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.3,
                    color: ColorPicker.buttonColor,
                    child: Center(
                      child: CommonText.textBold700P(text: 'Gallery'),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    _appProfileController.getCamaroImage().then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Center(
                        child: CommonText.textBold700P(text: 'Camera'),
                      ),
                    ),
                    height: Get.height * 0.06,
                    width: Get.width * 0.3,
                    color: ColorPicker.buttonColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  uploadImgFirebaseStorage({File? file, final progress}) async {
    var ref = await kFireStore
        .collection("UserAllData")
        .where("handle_small_name", isEqualTo: '+' + _userNameController.text)
        .get();
    ref.docs.forEach((element) {
      print('-----element[handle_small_name]  ${element['handle_small_name']}');
      getHandelName = element['handle_small_name'];
    });
    if (getHandelName != '+' + _userNameController.text.toLowerCase()) {
      if (_appProfileController.profileImage != null) {
        var snapshot = await kFirebaseStorage
            .ref()
            .child('UserProfileImage/${DateTime.now().microsecondsSinceEpoch}')
            .putFile(file!);
        downloadUrl = await snapshot.ref.getDownloadURL();
        print('url=$downloadUrl');
      }
      _userData.userName = '+' + _userNameController.text;
      _userData.name = _nameController.text;
      _userData.userImage =
          _appProfileController.profileImage != null ? downloadUrl : '';
      _userData.profileDetails = false;
      _userData.paymentMode = _appProfileController.byDefaultCurrency;
      _userData.tellUsAbout =
          _tellUsController.text.isEmpty ? '' : _tellUsController.text;
      _userData.authToken = PreferenceManager.getTokenId();
      _userData.searchSmallName = _nameController.text.toLowerCase();
      _userData.fcmToken = PreferenceManager.getFcmToken();
      _userData.profession =
          _professionController.text.isEmpty ? '' : _professionController.text;
      _userData.handleSmallName = '+' + _userNameController.text.toLowerCase();
      print('-----_userData----${_userData.toJson()}');
      PreferenceManager.setNotSearchHandel(
          '+' + _userNameController.text.toLowerCase());
      PreferenceManager.setFnameId(_nameController.text);
      if (_appProfileController.profileImage != null) {
        PreferenceManager.setImage(downloadUrl!);
      }
      PreferenceManager.setNotSearchName(_nameController.text.toLowerCase());

      kFireStore
          .collection('chat')
          .doc('5j0vHxBk0wfCJuIw70NoCyrePlo2-${PreferenceManager.getTokenId()}')
          .set({
        'name': _nameController.text,
        'name1': '+App Admin',
        'userImage': downloadUrl,
        'userImage1': '',
        'auth_Token': PreferenceManager.getTokenId(),
        "auth_Token1": '5j0vHxBk0wfCJuIw70NoCyrePlo2',
      });
      kFireStore
          .collection("UserAllData")
          .doc(PreferenceManager.getTokenId())
          .set(_userData.toJson())
          .then((value) {
        print('success add');
        // kFireStore.collection('chat')
      }).catchError((e) => print('upload error'));
      _user.emailOrPhone = '';
      _user.password = '123456';

      RelaysiaAuthResponse _responseR = await RegisterRelysiaRepo()
          .registerRelysiaRepo(isLogin: true, body: _user.toJson());
      print('login ralisiya done');
      if (_responseR.statusCode == 200) {
        PreferenceManager.setRelasiyaToken(_responseR.data!.token!);
        Map<String, String> header = {
          "authToken": _responseR.data!.token!,
          "walletTitle": '+' + _userNameController.text
        };

        await _createWalletViewModel.createWalletViewModel(header: header);
        CreateWalletResponse res1 = _createWalletViewModel.apiResponse.data;
        PreferenceManager.setWalletId(res1.data!.walletId!);

        if (res1.statusCode == 200) {
          print('-----walletId------   ${res1.data!.walletId}');
          Map<String, String> header1 = {
            "authToken": _responseR.data!.token!,
            "walletID": res1.data!.walletId!
          };

          await _addressIdTraViewModel.getAddressIdTraViewModel(
              header: header1);
          GetAddressIdResponse res2 = _addressIdTraViewModel.apiResponse.data;
          PreferenceManager.setTransferId(res2.data!.address!);
          kFireStore
              .collection("UserAllData")
              .doc(PreferenceManager.getTokenId())
              .update({
            'relysia_token': PreferenceManager.getRelasiyaToken(),
            'relysia_wallet_id': res1.data!.walletId,
            'transaction_id': res2.data!.address,
            'profileDetails': true
          });
          var headers = {
            'authToken': '${_responseR.data!.token!}',
            'walletID': 'e10de1a0-a306-4d19-9d1f-21e8c5b0c323',
            'Content-Type': 'application/json'
          };
          var request = http.Request(
              'POST', Uri.parse('https://api.relysia.com/v1/send'));
          request.body = json.encode({
            "dataArray": [
              {
                "to": res2.data!.address,
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
            Get.offAll(AppCharges());
            progress!.dismiss();
          } else {
            progress!.dismiss();

            CommonSnackBar.showSnackBar(
                msg: 'Free Bsv not credit', successStatus: false);
          }
          // _bottomController.bottomIndex.value = 3;
          // _bottomController.selectedScreen('UserHomeWidget');
        } else {
          progress!.dismiss();

          CommonSnackBar.showSnackBar(
              msg: '${res1.data!.msg}', successStatus: false);
        }
      } else {
        progress!.dismiss();

        return CommonSnackBar.showSnackBar(
            msg: 'Details not update', successStatus: false);
      }
      // Get.to(NavigationBarScreen());
    } else {
      return CommonSnackBar.showSnackBar(
          msg: 'Please enter unique Handle name', successStatus: false);
    }
  }
}
