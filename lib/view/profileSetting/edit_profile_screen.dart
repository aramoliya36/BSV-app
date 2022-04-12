import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/edit_profile_controller.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/coomon_snackbar.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/common/text_filed.dart';
import 'package:consultancy/model/requestModel/user_data_req.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/charges/app_charges.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditProfileApp extends StatefulWidget {
  const EditProfileApp({Key? key}) : super(key: key);

  @override
  _EditProfileAppState createState() => _EditProfileAppState();
}

class _EditProfileAppState extends State<EditProfileApp> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  EditProfileController _editProfileController = Get.find();
  bool? isEmailValid;

  final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
  UserAllDataRequest _userData = UserAllDataRequest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      appBar: CommonWidget.appBarWithTitle(title: 'Edit Profile'),
      body: ProgressHUD(
        child: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        GetBuilder<EditProfileController>(
                          builder: (controller) {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 68.sp,
                                width: 68.sp,
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
                            right: 104.sp,
                            child: InkWell(
                              onTap: () {
                                buttonChangeProfile();
                              },
                              child: Container(
                                height: 30.sp,
                                child: Image.asset(
                                  'assets/images/pan_icon.png',
                                ),
                              ),
                            ))
                      ],
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textMediumDynamicColorP(
                              text: 'Name',
                              textColor: ColorPicker.whiteColor,
                              textSize: 13.sp),
                          CommonTextFiled.commonTextFiled(
                              controller: _nameController,
                              hintText: 'name',
                              onChange: (v) {}),
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textMediumDynamicColorP(
                              text: 'Phone',
                              textColor: ColorPicker.whiteColor,
                              textSize: 13.sp),
                          Container(
                            //color: Colors.deepOrange,
                            height: 6.h,
                            child: TextFormField(
                              controller: _phoneController,
                              cursorColor: ColorPicker.whiteColor,
                              style: CommonText.textStyleSemiBold600Normal(),
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: ColorPicker.hintTextColor,
                                      width: 1.5),
                                ),
                                hintText: 'phone',
                                contentPadding: EdgeInsets.all(10.sp),
                                hintStyle: TextStyle(
                                    color: ColorPicker.hintTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: ColorPicker.hintTextColor,
                                      width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide(
                                      color: ColorPicker.hintTextColor,
                                      width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textMediumDynamicColorP(
                              text: 'Email',
                              textColor: ColorPicker.whiteColor,
                              textSize: 13.sp),
                          CommonTextFiled.commonTextFiled(
                              controller: _emailController,
                              hintText: 'email',
                              onChange: (v) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailController.text)) {
                                  isEmailValid = true;
                                  print('is all valid $isEmailValid');
                                } else {
                                  print('is all novalid $isEmailValid');

                                  isEmailValid = false;
                                }
                              }),
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textMediumDynamicColorP(
                              text: 'About  ',
                              textColor: ColorPicker.whiteColor,
                              textSize: 13.sp),
                          CommonTextFiled.commonTextFiled(
                              controller: _aboutController,
                              hintText: 'About',
                              onChange: (v) {}),
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * .03),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: CommonButton.commonSignButtonWithoutIcon(
                          name: "Submit",
                          onTap: () async {
                            if (_editProfileController.profileImage != null) {
                              if (_nameController.text.isNotEmpty &&
                                  _phoneController.text.isNotEmpty &&
                                  _aboutController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty) {
                                if (_phoneController.text.length == 10) {
                                  if (isEmailValid == true) {
                                    final progress = ProgressHUD.of(context);
                                    progress?.show();

                                    await uploadImgFirebaseStorage(
                                        file: _editProfileController
                                            .profileImage);

                                    progress?.dismiss();
                                    Get.to(AppCharges());
                                  } else {
                                    CommonSnackBar.showSnackBar(
                                        msg: "Please valid email",
                                        successStatus: false);
                                  }
                                } else {
                                  CommonSnackBar.showSnackBar(
                                      msg: "Please valid mobile",
                                      successStatus: false);
                                }
                              } else {
                                CommonSnackBar.showSnackBar(
                                    msg: "Please enter name",
                                    successStatus: false);
                              }
                            } else {
                              CommonSnackBar.showSnackBar(
                                  msg: "Please select image",
                                  successStatus: false);
                            }
                          },
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  buttonChangeProfile() {
    Get.dialog(Center(
      child: Material(
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
                    _editProfileController.getGalleryImage().then((value) {
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
                    _editProfileController.getCamaroImage().then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Camera',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: ColorPicker.whiteColor,
                            fontSize: 10.sp),
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

  uploadImgFirebaseStorage({File? file}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('UserProfileImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    _userData.userName = _nameController.text;
    _userData.phone = _phoneController.text;
    _userData.email = _emailController.text;
    _userData.about = _aboutController.text;
    _userData.userImage = downloadUrl;

    print('-----_userData----${_userData.toJson()}');
    kFireStore
        .collection("UserAllData")
        .doc()
        .collection("uid1")
        .add(_userData.toJson())
        .then((value) {
      print('success add');
    }).catchError((e) => print('upload error'));
  }
}
