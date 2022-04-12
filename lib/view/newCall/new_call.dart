import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewCallScreen extends StatefulWidget {
  const NewCallScreen({Key? key}) : super(key: key);

  @override
  _NewCallScreenState createState() => _NewCallScreenState();
}

class _NewCallScreenState extends State<NewCallScreen> {
  List<Contact>? contacts = [];

  bool _permissionDenied = false;

  BottomController _bottomController = Get.find();
  @override
  void initState() {
    _fetchContacts();
    super.initState();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts1 = await FlutterContacts.getContacts();
      //  contacts = contacts1;

      setState(() {
        contacts = contacts1;
      });
      print('----------------------$contacts1');
    }
  }

  var temp;
  var temp2;

  RegExp _isLetterRegExp = RegExp(r'[a-z]', caseSensitive: false);
  bool isLetter(String letter) => _isLetterRegExp.hasMatch(letter);

  ///
  bool contactsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ColorPicker.themBlackColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                _bottomController.bottomIndex.value = 0;
                //
                _bottomController.setSelectedScreen('RecentCallScreen');
              },
            ),
            backgroundColor: ColorPicker.themBlackColor,
            title: CommonText.textBold700PDynamicP(
                text: "New Call",
                fontSize: 18.sp,
                textColor: ColorPicker.whiteColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff626262),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Color(0xffC8C8C8)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 0, bottom: 2),
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorPicker.whiteColor,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: ColorPicker.whiteColor)),
                    ),
                    height: Get.height * 0.05,
                    width: Get.width,
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                  buildRow(
                      function: () {},
                      svgImage: "assets/svg/schedule_call.svg",
                      title: "SCHEDULE A CALL"),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.015),
                  buildRow(
                      svgImage: "assets/svg/multi_person.svg",
                      title: "SET UP A NEW GROUP"),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.015),
                  buildRow(
                      svgImage: "assets/svg/invite_f_.svg",
                      title: "NEW CONTACT"),
                  contacts!.isNotEmpty
                      ? ListView.builder(
                          itemCount: contacts!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final RegExp nameRegExp = RegExp('[a-zA-Z]');

                            //  Contact? contact = contacts?.elementAt(index);
                            print(
                                '---------contacts![index].displayName   ${contacts![index].displayName.runtimeType}');
                            if (contacts![index].isNull) {
                            } else {
                              if (contacts![index].displayName != '' &&
                                  contacts![index].displayName.isNotEmpty) {
                                // print('hello');
                                // contacts!.sort((a, b) {
                                //   print('a.displayName   ${a.displayName}');
                                //   return a.displayName
                                //       .toString()
                                //       .compareTo(b.displayName.toString());
                                // });

                                if (nameRegExp.hasMatch(contacts![index]
                                    .displayName[0]
                                    .toUpperCase())) {
                                  if (temp2 ==
                                      contacts![index]
                                          .displayName[0]
                                          .toUpperCase()) {
                                    if (isLetter(
                                        contacts![index].displayName[0])) {
                                      temp2 = contacts![index]
                                          .displayName[0]
                                          .toUpperCase();
                                      temp = 0;
                                    }
                                  } else {
                                    if (isLetter(contacts![index]
                                        .displayName[0]
                                        .toUpperCase())) {
                                      print('temp1');
                                      temp2 = contacts![index]
                                          .displayName[0]
                                          .toUpperCase();
                                      temp = 1;
                                    }
                                  }
                                }
                              }
                            }
                            return contacts!.isEmpty
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      contacts![index].isNull == true
                                          ? SizedBox()
                                          : nameRegExp.hasMatch(contacts![index]
                                                      .displayName) &&
                                                  temp == 1
                                              ? Text(
                                                  '$temp2',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : SizedBox(),

                                      // temp == 1 &&
                                      //         contacts![index].isNull == false
                                      //     ? Text(
                                      //         '$temp2',
                                      //         style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 18,
                                      //             fontWeight: FontWeight.w500),
                                      //       )
                                      //     : SizedBox(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      contacts![index].isNull == true
                                          ? SizedBox()
                                          : nameRegExp.hasMatch(
                                                  contacts![index].displayName)
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              Get.height * 0.06,
                                                          width:
                                                              Get.width / 2.5,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                height: 34.sp,
                                                                width: 34.sp,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.01,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  contacts![index]
                                                                              .isNull ==
                                                                          false
                                                                      ? Container(
                                                                          width:
                                                                              Get.width / 4,
                                                                          child:
                                                                              Text(
                                                                            '${contacts![index].displayName}',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Poppins',
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: ColorPicker.whiteColor,
                                                                                fontSize: 10.sp),
                                                                          ),
                                                                        )
                                                                      : SizedBox(),

                                                                  // /Spacer()
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CommonWidget
                                                                    .svgPicture(
                                                                        image:
                                                                            'assets/svg/schedule_icon.svg'),
                                                                CommonText.textSemiBoldDynamicP(
                                                                    fontSize:
                                                                        8.sp,
                                                                    text: '',
                                                                    textColor:
                                                                        ColorPicker
                                                                            .hintTextColor)
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                            ),
                                                            CommonSizeBox
                                                                .commonSizeBox(
                                                                    width:
                                                                        10.sp),

                                                            Column(
                                                              children: [
                                                                Container(
                                                                    height:
                                                                        18.sp,
                                                                    width:
                                                                        15.sp,
                                                                    child: CommonWidget
                                                                        .svgPicture(
                                                                            image:
                                                                                'assets/svg/video_icon.svg')),
                                                                CommonSizeBox.commonSizeBox(
                                                                    height: Get
                                                                            .height *
                                                                        0.001),
                                                                CommonText.textSemiBoldDynamicP(
                                                                    fontSize:
                                                                        8.sp,
                                                                    text: '',
                                                                    textColor:
                                                                        ColorPicker
                                                                            .hintTextColor)
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                            ),
                                                            CommonSizeBox
                                                                .commonSizeBox(
                                                                    width:
                                                                        10.sp),

                                                            Column(
                                                              children: [
                                                                Container(
                                                                    height:
                                                                        18.sp,
                                                                    width:
                                                                        15.sp,
                                                                    child: CommonWidget
                                                                        .svgPicture(
                                                                            image:
                                                                                'assets/svg/call_bold_icon.svg')),
                                                                CommonSizeBox.commonSizeBox(
                                                                    height: Get
                                                                            .height *
                                                                        0.001),
                                                                CommonText.textSemiBoldDynamicP(
                                                                    fontSize:
                                                                        8.sp,
                                                                    text: '',
                                                                    textColor:
                                                                        ColorPicker
                                                                            .hintTextColor)
                                                              ],
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                            ),

                                                            //CommonSizeBox.commonSizeBox(width: 4.sp),
                                                          ],
                                                        ),
                                                      ],
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                    ],
                                  );
                          },
                        )
                      : Center(
                          child: const CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          color: Colors.green,
                        )),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          _bottomController.bottomIndex.value = 0;
          _bottomController.selectedScreen('RecentCallScreen');

          return Future.value(false);
        });
  }

  Widget statusRow(
      {String? title,
      String? subTitle,
      String? image,
      String? image1,
      String? date,
      String? date1,
      TextOverflow? overflow}) {
    return Row(
      children: [
        Container(
          height: Get.height * 0.06,
          width: Get.width / 2.5,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/user_image.png')),
                    shape: BoxShape.circle),
                height: 34.sp,
                width: 34.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width / 3.5,
                    child: Text(
                      title!,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          color: ColorPicker.whiteColor,
                          fontSize: 10.sp),
                    ),
                  ),

                  Text(
                    subTitle!,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 8.sp,
                        overflow: TextOverflow.ellipsis,
                        color: ColorPicker.hintTextColor),
                  ),
                  CommonSizeBox.commonSizeBox(height: 2.sp)
                  // /Spacer()
                ],
              ),
            ],
          ),
        ),
        Container(
          height: Get.height * 0.06,
          width: Get.width / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.svgPicture(image: image!),
                  CommonText.textSemiBoldDynamicP(
                      fontSize: 8.sp,
                      text: date!,
                      textColor: ColorPicker.hintTextColor)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              // CommonSizeBox.commonSizeBox(width: 4.sp),

              Column(
                children: [
                  Container(
                      height: 18.sp,
                      width: 15.sp,
                      child: CommonWidget.svgPicture(image: image1!)),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.001),
                  CommonText.textSemiBoldDynamicP(
                      fontSize: 8.sp,
                      text: date,
                      textColor: ColorPicker.hintTextColor)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Column(
                children: [
                  Container(
                      height: 18.sp,
                      width: 15.sp,
                      child: CommonWidget.svgPicture(
                          image: 'assets/svg/call_bold_icon.svg')),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.001),
                  CommonText.textSemiBoldDynamicP(
                      fontSize: 8.sp,
                      text: date,
                      textColor: ColorPicker.hintTextColor)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),

              //CommonSizeBox.commonSizeBox(width: 4.sp),
            ],
          ),
        ),
      ],
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget frequentlyRowCommon({
    String? title,
    String? subTitle,
    String? digit,
    String? subTitle1,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText.textMediumDynamicColorP(
                textSize: 10.sp,
                text: title!,
                textColor: ColorPicker.whiteColor),
            SizedBox(
              height: Get.height * 0.002,
            ),
            CommonText.textSemiBoldDynamicP(
                text: subTitle!, textColor: ColorPicker.hintTextColor)
          ],
        ),
        Column(
          children: [
            CommonText.textMediumDynamicColorP(
                text: digit!, textColor: ColorPicker.hintTextColor),
            SizedBox(
              height: Get.height * 0.002,
            ),
            CommonText.textSemiBoldDynamicP(
                fontSize: 8.sp,
                text: subTitle1!,
                textColor: ColorPicker.callTimeGreenColor)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
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
            child: CommonWidget.svgPicture(
              image: svgImage!,
            ),
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
}
