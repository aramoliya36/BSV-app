import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewChatScreen1 extends StatefulWidget {
  const NewChatScreen1({Key? key}) : super(key: key);

  @override
  _NewChatScreen1State createState() => _NewChatScreen1State();
}

class _NewChatScreen1State extends State<NewChatScreen1> {
  List<Contact>? contacts = [];

  bool _permissionDenied = false;

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
      contacts = contacts1;

      // setState(() {
      //   contacts = contacts1;
      // });
      print('----------------------${contacts1}');
    }
  }

  var temp;
  var temp2;

  RegExp _isLetterRegExp = RegExp(r'[a-z]', caseSensitive: false);
  bool isLetter(String letter) => _isLetterRegExp.hasMatch(letter);

  ///
  bool contactsLoaded = false;

  // Future<void> getContacts() async {
  //   //We already have permissions for contact when we get to this page, so we
  //   // are now just retrieving it
  //   final Iterable<Contact> contacts = await ContactsService.getContacts();
  //   setState(() {
  //     _contacts = contacts;
  //   });
  //
  //   print('CONTACTS:-${_contacts!.first.displayName}');
  // }

  BottomController _bottomController = Get.find();
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
                _bottomController.bottomIndex.value = 2;
                //
                _bottomController.setSelectedScreen('UserHomeWidget');
              },
            ),
            backgroundColor: ColorPicker.themBlackColor,
            title: CommonText.textBold700PDynamicP(
                text: "New Chat",
                fontSize: 18.sp,
                textColor: ColorPicker.whiteColor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _bottomController.selectedScreen('SearchScreen');
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
                                text: 'Search',
                                textColor: ColorPicker.whiteColor)
                          ],
                        ),
                      ),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                    buildRow(
                        svgImage: "assets/svg/multi_person.svg",
                        title: "SET UP A NEW GROUP"),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                    contacts!.isNotEmpty
                        ? ListView.builder(
                            itemCount: contacts!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              //  Contact? contact = contacts?.elementAt(index);
                              print(
                                  '---------contacts![index].displayName   ${contacts![index].displayName.runtimeType}');
                              if (contacts![index].displayName != '' &&
                                  contacts![index].displayName.isNotEmpty &&
                                  contacts![index].displayName == null) {
                                print('hello');
                                contacts!.sort((a, b) {
                                  print('a.displayName   ${a.displayName}');
                                  return a.displayName
                                      .toString()
                                      .compareTo(b.displayName.toString());
                                });

                                if (temp2 == contacts![index].displayName[0]) {
                                  if (isLetter(
                                      contacts![index].displayName[0])) {
                                    temp2 = contacts![index].displayName[0];
                                    temp = 0;
                                  }
                                } else {
                                  if (isLetter(
                                      contacts![index].displayName[0])) {
                                    temp2 = contacts![index].displayName[0];
                                    temp = 1;
                                  }
                                }
                              }
                              return contacts![index].displayName == null
                                  ? SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        temp == 1
                                            ? Text(
                                                '${temp2}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: Get.height * 0.06,
                                                  width: Get.width / 2.5,
                                                  child: Row(
                                                    children: [
                                                      // Container(
                                                      //   decoration: BoxDecoration(
                                                      //       image: DecorationImage(
                                                      //           image: AssetImage(
                                                      //               'assets/images/user_image.png')),
                                                      //       shape: BoxShape.circle),
                                                      //   height: 34.sp,
                                                      //   width: 34.sp,
                                                      // ),
                                                      // SizedBox(
                                                      //   width: Get.width * 0.01,
                                                      // ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width:
                                                                Get.width / 4,
                                                            child: Text(
                                                              '${contacts![index].displayName}',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: ColorPicker
                                                                      .whiteColor,
                                                                  fontSize:
                                                                      10.sp),
                                                            ),
                                                          ),

                                                          CommonSizeBox
                                                              .commonSizeBox(
                                                                  height: 2.sp)
                                                          // /Spacer()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  height: Get.height * 0.06,
                                                  width: Get.width / 4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CommonWidget.svgPicture(
                                                          image:
                                                              'assets/svg/chat-svgrepo-com (1) 2.svg'),
                                                      // CommonText
                                                      //     .textSemiBoldDynamicP(
                                                      //         fontSize: 8.sp,
                                                      //         text: DateTime.now()
                                                      //             .toString(),
                                                      //         textColor: ColorPicker
                                                      //             .hintTextColor)
                                                      CommonText
                                                          .textSemiBoldDynamicP(
                                                              fontSize: 8.sp,
                                                              text: 'free',
                                                              textColor: ColorPicker
                                                                  .hintTextColor)
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                  ),
                                                ),
                                              ],
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                              //   ListTile(
                              //   contentPadding:
                              //   const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                              //   leading: CircleAvatar(
                              //     child: Text(contact!.initials()),
                              //     backgroundColor: Theme.of(context).accentColor,
                              //   ),
                              //   title: Text(contact.displayName ?? ''),
                              //   trailing: Icon(
                              //     Icons.call,
                              //     color: Colors.green,
                              //     size: 30,
                              //   ),
                              //   //subtitle: Text(contact.phones![index].value ?? ''),
                              // );
                            },
                          )
                        //     //Build a list view of all contacts, displaying their avatar and
                        //     // display name
                        //     // ? Container(
                        //     //     height: Get.height,
                        //     //     width: Get.width,
                        //     //     child: ListView.builder(
                        //     //       itemCount: _contacts?.length ?? 0,
                        //     //       itemBuilder: (BuildContext context, int index) {
                        //     //         Contact? contact = _contacts?.elementAt(index);
                        //     //         return ListTile(
                        //     //           contentPadding: const EdgeInsets.symmetric(
                        //     //               vertical: 2, horizontal: 18),
                        //     //           leading: CircleAvatar(
                        //     //             child: Text(contact!.initials()),
                        //     //             backgroundColor:
                        //     //                 Theme.of(context).accentColor,
                        //     //           ),
                        //     //           title: Text(contact.displayName ?? ''),
                        //     //           trailing: Icon(
                        //     //             Icons.call,
                        //     //             color: Colors.green,
                        //     //             size: 30,
                        //     //           ),
                        //     //           //subtitle: Text(contact.phones![index].value ?? ''),
                        //     //         );
                        //     //       },
                        //     //     ),
                        //     //   )
                        : Center(
                            child: const CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            color: Colors.green,
                          )),
                    Text(
                      "A",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                          color: ColorPicker.whiteColor),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                    Column(
                      children: [
                        statusRow(
                            title: "Adeyemi Peter",
                            subTitle: "Online",
                            image: "assets/svg/schedule_icon.svg",
                            date: "\$3 p/min",
                            image1: "assets/svg/video_icon.svg",
                            date1: "\$4 p/min"),
                        CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                        statusRow(
                            title: "Alphoson Johnson",
                            subTitle: "Online",
                            image: "assets/svg/schedule_icon.svg",
                            date: "free",
                            image1: "assets/svg/video_icon.svg",
                            date1: "free"),
                        CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                        statusRow(
                            title: "Alphoson Johnson",
                            subTitle: "Online",
                            image: "assets/svg/schedule_icon.svg",
                            date: "free",
                            image1: "assets/svg/video_icon.svg",
                            date1: "free"),
                      ],
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                    Text(
                      "B",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                          color: ColorPicker.whiteColor),
                    ),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                    Column(
                      children: [
                        statusRow(
                            title: "Benson James",
                            subTitle: "Online",
                            image: "assets/svg/schedule_icon.svg",
                            date: "\$0.2 p/msg",
                            image1: "assets/svg/video_icon.svg",
                            date1: "\$3 p/min"),
                        CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                        statusRow(
                            title: "Benard Lee",
                            subTitle: "Online",
                            image: "assets/svg/schedule_icon.svg",
                            date: "free",
                            image1: "assets/svg/video_icon.svg",
                            date1: "free"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          print('wilpop');
          /*  Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return NavigationBarScreen();
            },
          ));*/
          //  Get.offAll(NavigationBarScreen());

          _bottomController.bottomIndex.value = 2;
          //
          _bottomController.setSelectedScreen('UserHomeWidget');

          // print(_bottomController.bottomIndex.value);

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
              SizedBox(
                width: Get.width * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width / 4,
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
        Spacer(),
        Container(
          height: Get.height * 0.06,
          width: Get.width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.svgPicture(
                  image: 'assets/svg/chat-svgrepo-com (1) 2.svg'),
              CommonText.textSemiBoldDynamicP(
                  fontSize: 8.sp,
                  text: date!,
                  textColor: ColorPicker.hintTextColor)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
