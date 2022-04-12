import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/common_drawer.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/services/google_sign_in.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:consultancy/view/newCall/new_call.dart';
import 'package:consultancy/view/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RecentCallScreen extends StatefulWidget {
  const RecentCallScreen({Key? key}) : super(key: key);

  @override
  _RecentCallScreenState createState() => _RecentCallScreenState();
}

class _RecentCallScreenState extends State<RecentCallScreen> {
  BottomController _bottomController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // FlutterRingtonePlayer.stop();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorPicker.themBlackColor,
        drawer: CommonDrawer.commonDrawer(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                      color: ColorPicker.whiteColor, width: 2),
                                  shape: BoxShape.circle,
                                  color: ColorPicker.greenIndicatorColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(width: 4.sp),
                    CommonText.textBold700PDynamicP(
                        text: "Recent Calls",
                        fontSize: 18.sp,
                        textColor: ColorPicker.whiteColor),
                    Spacer(),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              _bottomController.selectedScreen('NewCallScreen');
                              _bottomController.bottomIndex(0);
                            },
                            child:
                                SvgPicture.asset("assets/svg/call_icon.svg")),
                        CommonSizeBox.commonSizeBox(height: 5.sp),
                      ],
                    ),
                  ],
                ),
                // buildRow(
                //     svgImage: "assets/svg/multi_person.svg",
                //     title: "ADD PEOPLE NEARBY"),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                InkWell(
                  onTap: () {
                    _bottomController.selectedScreen('SearchScreen');
                    _bottomController.bottomIndex.value = 3;
                  },
                  child: Container(
                    width: double.infinity,
                    height: 26.sp,
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
                          color: ColorPicker.hintTextColor,
                        ),
                        CommonText.textMediumDynamicColorP(
                            text: 'Search',
                            textColor: ColorPicker.hintTextColor)
                      ],
                    ),
                  ),
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.016),

                InkWell(
                  onTap: () {
                    Get.to(NewCallScreen());
                  },
                  child: buildRow(
                      svgImage: "assets/svg/invite_f_.svg",
                      title: "INVITE FRIENDS"),
                ),

                //CommonSizeBox.commonSizeBox(height: Get.height * 0.01),

                Divider(
                  color: Color(0xfffA3A3A3),
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.01),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('UserAllData')
                      .doc(PreferenceManager.getTokenId())
                      .collection('callHistory')
                      .orderBy('date_time', descending: false)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.length == 0
                          ? Center(
                              child: CommonText.textMediumDynamicColorP(
                                  text: 'No call history',
                                  textColor: ColorPicker.whiteColor),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var _res = snapshot.data!.docs[index];

                                return frequentlyRowCommon(
                                    timeColor: _res['isReceivedCall'] == true
                                        ? ColorPicker.callTimeGreenColor
                                        : ColorPicker.callTimeRedColor,
                                    callInOut: index.isEven
                                        ? "assets/svg/outgoing_arrow.svg"
                                        : "assets/svg/incoming_call_icon.svg",
                                    callIcon: _res['isVideoCall'] == false
                                        ? "assets/svg/call_green.svg"
                                        : "assets/svg/video_call_green.svg",
                                    info: "assets/svg/info_icon.svg",
                                    title: _res['callerName'],
                                    subTitle: "10:23 AM",
                                    imageDp: _res['image'] ?? '',
                                    subTitle1: "\$10.50");
                              },
                            );
                    } else {
                      return circularProgress();
                    }
                  },
                ),
                CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildRow({String? svgImage, String? title, dynamic function}) {
  return GestureDetector(
    onTap: function,
    child: Row(
      children: [
        Container(
          height: Get.height * 0.03,
          width: Get.width * 0.08,
          // color: Colors.red,
          child: CommonWidget.svgPicture(image: svgImage!),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        CommonText.textBold700PDynamicP(
            text: title!, textColor: ColorPicker.whiteColor, fontSize: 10.sp)
      ],
    ),
  );
}

Widget frequentlyRowCommon(
    {String? title,
    String? subTitle,
    String? callInOut,
    String? callIcon,
    String? info,
    String? imageDp,
    Color? timeColor,
    String? subTitle1,
    TextOverflow? overflow}) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            height: 34.sp,
            width: 34.sp,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: imageDp == ''
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                      )
                    : Image.network(
                        imageDp!,
                        fit: BoxFit.cover,
                      )),
          ),
          Container(
            //   height: Get.height * 0.050,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.textMediumDynamicColorP(
                    textSize: 10.sp,
                    text: title!,
                    textColor: ColorPicker.whiteColor),
                Row(
                  children: [
                    SvgPicture.asset(callInOut!),
                    SizedBox(
                      width: Get.width * 0.015,
                    ),
                    CommonText.textSemiBoldDynamicP(
                        fontSize: 9.sp,
                        text: subTitle!,
                        textColor: ColorPicker.hintTextColor)
                  ],
                )
              ],
            ),
          ),
          CommonSizeBox.commonSizeBox(
            width: Get.width * 0.025,
          ),
          CommonSizeBox.commonSizeBox(
            width: 40.sp,
          ),
          Column(
            children: [
              Container(
                  height: Get.height * 0.02,
                  width: Get.width * 0.05,
                  // color: Colors.red,
                  child: SvgPicture.asset(callIcon!)),
              SizedBox(
                height: Get.height * 0.008,
              ),
              CommonText.textSemiBoldDynamicP(
                  fontSize: 8.sp, text: subTitle, textColor: timeColor)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Container(
              height: Get.height * 0.05,
              width: Get.width * 0.05,
              // color: Colors.red,
              child: Center(child: SvgPicture.asset(info!))),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      CommonSizeBox.commonSizeBox(
        height: Get.height * 0.02,
      ),
    ],
  );
}
