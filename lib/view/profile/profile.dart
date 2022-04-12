import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonSizeBox.commonSizeBox(height: Get.height * .03),
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
              Center(
                child:
                    CommonWidget.svgPicture(image: 'assets/svg/circul_svg.svg'),
              ),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              CommonText.textSemiBoldDynamicP(
                  text: 'LAURA LAURYL',
                  textColor: Colors.white,
                  fontSize: 18.sp),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Color(0xFF238C73),
                  child: CommonText.textSemiBoldDynamicP(
                      text: '+Lauryl',
                      textColor: Colors.white,
                      fontSize: 10.sp),
                  onPressed: () {}),
              CommonSizeBox.commonSizeBox(height: Get.height * .01),
              CommonText.textSemiBoldDynamicP(
                  text: 'Bitcoin Consultant',
                  textColor: Colors.white,
                  fontSize: 12.sp),
              CommonSizeBox.commonSizeBox(height: Get.height * .02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: CommonText.textMediumP(
                  text:
                      "I have 7+ years experiences in Family  Law ,Securities & Finance law,' particular around Fintechs Companys. Strength include good commnunication skills....... more",
                  // textAlign: TextAlign.center,
                ),
              ),
              CommonSizeBox.commonSizeBox(height: Get.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CommonWidget.svgPicture(
                          image: 'assets/svg/call_bold_icon.svg'),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      CommonText.textBold700P(text: '\$1.20'),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      CommonText.textSemiBoldDynamicP(
                          text: 'Per Minute',
                          fontSize: 10.sp,
                          textColor: Colors.white),
                    ],
                  ),
                  CommonWidget.svgPicture(image: 'assets/svg/vertical_de.svg'),
                  Column(
                    children: [
                      CommonWidget.svgPicture(
                          image: 'assets/svg/video_icon.svg'),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      CommonText.textBold700P(text: '\$1.20'),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      CommonText.textSemiBoldDynamicP(
                          text: 'Per Minute',
                          fontSize: 10.sp,
                          textColor: Colors.white),
                    ],
                  ),
                  CommonWidget.svgPicture(image: 'assets/svg/vertical_de.svg'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonWidget.svgPicture(
                          image: 'assets/svg/message_icon_bold.svg'),
                      CommonSizeBox.commonSizeBox(height: Get.height * .01),
                      CommonText.textBold700PDynamicP(
                          text: 'Free',
                          fontSize: 12.sp,
                          textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
