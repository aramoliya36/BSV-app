import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.themBlackColor,
      body: SafeArea(
        child: Column(
          children: [
            CommonWidget.rowTwoAppBarIcon(
              image1: "assets/svg/User_Active.svg",
              onTap: () {},
              image2: "assets/svg/message_icon.svg",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                      height: Get.height * 0.05,
                      width: Get.width * 1.10,
                      color: Color(0xff626262),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                      )),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Container(
                    height: Get.height * 0.25,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Container(
                              height: Get.height * 0.13,
                              width: Get.width * 0.5,
                              // color: Colors.red,
                              child: CommonText.textBold700PDynamicP(
                                  text: "Would you like to Speak to a Lawyer?",
                                  textColor: Colors.white,
                                  fontSize: 23),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 0.32,
                              decoration: BoxDecoration(
                                  color: Color(0xff1CACB8),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: CommonText.textMediumDynamicColorP(
                                    text: "Hire Now", textSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xff0B0B45),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CommonText.textBold700PDynamicP(
                      text: "ALL CATEGORIES",
                      fontSize: 18,
                      textColor: ColorPicker.whiteColor),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    height: Get.height * 0.40,
                    // color: Colors.pink,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          ///=======Accounting==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/accountingIcon.svg",
                              title: "Accounting"),

                          ///=======Administration==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Administration.svg",
                              title: "Administration"),

                          ///=======Celebrity==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Celebrity.svg",
                              title: "Celebrity"),

                          ///=======Counselling==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Counselling.svg",
                              title: "Counselling"),

                          ///=======Coaching==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Coaching.svg",
                              title: "Coaching"),

                          ///=======Dental==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Dental.svg",
                              title: "Dental"),

                          ///=======Design==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Design.svg",
                              title: "Design"),

                          ///=======Engineering==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Engineering.svg",
                              title: "Engineering"),

                          ///=======Entertainment==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Entertainment.svg",
                              title: "Entertainment"),

                          ///=======Finance==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Finance.svg",
                              title: "Finance"),

                          ///=======Holistic Health==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Holistic Health.svg",
                              title: "Holistic Health"),

                          ///=======Information & Technology==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Information & Technology.svg",
                              title: "Information & Technology"),

                          ///=======Investors==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Investors.svg",
                              title: "Investors"),

                          ///=======Language==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Language.svg",
                              title: "Language"),

                          ///=======Legal Services==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Legal Services.svg",
                              title: "Legal Services"),

                          ///=======Medical==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Medical.svg",
                              title: "Medical"),

                          ///=======Mentoring==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Mentoring.svg",
                              title: "Mentoring"),

                          ///=======Music==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Music.svg",
                              title: "Music"),

                          ///=======Plumbing==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Plumbing.svg",
                              title: "Plumbing"),

                          ///=======Psychic==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Psychic.svg",
                              title: "Psychic"),

                          ///=======Sales & Marketing==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Sales & Marketing.svg",
                              title: "Sales & Marketing"),

                          ///=======Sport==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Sport.svg",
                              title: "Sport"),

                          ///=======Technology==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Technology.svg",
                              title: "Technology"),

                          ///=======Therapy==========///
                          SizedBox(
                            height: Get.height * 0.02,
                          ),

                          buildInkWellWIthRow(
                              onTap: () {},
                              image: "assets/svg/Therapy.svg",
                              title: "Therapy"),
                          SizedBox(
                            height: Get.height * 0.08,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell buildInkWellWIthRow({
    dynamic onTap,
    String? image,
    String? title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: Get.height * 0.030,
            width: Get.width * 0.08,
            // color: Colors.red,
            child: CommonWidget.svgPicture(
              image: image!,
            ),
          ),
          CommonSizeBox.commonSizeBox(width: Get.width * 0.05),
          CommonText.textMediumDynamicColorP(
              text: title!, textColor: ColorPicker.whiteColor, textSize: 17)
        ],
      ),
    );
  }
}
