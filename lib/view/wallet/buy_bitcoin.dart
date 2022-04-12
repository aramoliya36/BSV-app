import 'dart:convert';
import 'dart:developer';

import 'package:consultancy/ViewModel/get_balance_viewmodel.dart';
import 'package:consultancy/common/button_common.dart';
import 'package:consultancy/common/circularprogress_indicator.dart';
import 'package:consultancy/common/common_drawer.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/login_relasiya_repo.dart';
import 'package:consultancy/model/responseModel/balance_response.dart';
import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class BitCoinScreen extends StatefulWidget {
  const BitCoinScreen({Key? key}) : super(key: key);

  @override
  _BitCoinState createState() => _BitCoinState();
}

class _BitCoinState extends State<BitCoinScreen> {
  List images = [
    "assets/images/person_image.png",
    "assets/images/Profile_50px.png",
    "assets/images/User_50px.png",
    "assets/images/user_image.png"
  ];

  int _value = 42;
  bool swipe = false;
  String? usdValue = '0';
  GetBalanceViewModel _getBalanceViewModel = Get.find();
  currencyTra({String? satoshis}) async {
    print('--------------send satoshi  $satoshis');
    var headers = {'satoshis': '${satoshis}', 'currency': 'GBP'};
    var request = http.Request(
        'GET', Uri.parse('https://api.relysia.com/v1/currencyConversion'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
        print('------valeu  ${value}');
        var m = jsonDecode(value);
        _getBalanceViewModel.valueUsd = m['data']['balance'].toString();
        print('confirmed-- ${m['data']['balance']}');
      });

      // currencyTra(satoshis:{} );
    } else {
      print(response.reasonPhrase);
    }
  }

  getToken() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.whatsonchain.com/v1/bsv/main/address/${PreferenceManager.getTransferId()}/balance'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      await response.stream.bytesToString().then((value) {
        var m = jsonDecode(value);
        print('confirmed-- ${m['confirmed']}');
        print('confirmed-- ${m['unconfirmed']}');
        print('----m[unconfirmed]   ${m['confirmed'] + m['unconfirmed']}');
        currencyTra(satoshis: '${m['confirmed'] + m['unconfirmed']}');
      });
      // var jsonResponse = json.decode(response.body.toString());
    } else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Map<String, String>? header;
  @override
  void initState() {
    getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CommonDrawer.commonDrawer(context: context),
      bottomSheet: Material(
        color: ColorPicker.themBlackColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Container(
            height: Get.height * 0.52,
            width: Get.width * 1,
            // color: Colors.red,
            decoration: BoxDecoration(
                color: Color(0xff545454),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.01),
                  Container(
                    height: 10,
                    width: 70,
                    decoration: BoxDecoration(
                        color: ColorPicker.whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.02),
                  Row(
                    children: [
                      CommonText.textSemiBoldDynamicP(
                          text: "Lateset Transactions",
                          fontSize: 12.sp,
                          textColor: ColorPicker.whiteColor),
                      Spacer(),
                      CommonText.textSemiBoldDynamicP(
                          text: "View All ",
                          fontSize: 11.sp,
                          textColor: ColorPicker.hintTextColor),
                      InkWell(
                          onTap: () {
                            // DropdownButton(
                            //   value: _value,
                            //   items: <DropdownMenuItem<int>>[
                            //      DropdownMenuItem(
                            //       child:  Text('Foo'),
                            //       value: 0,
                            //     ),
                            //      DropdownMenuItem(
                            //       child:  Text('Bar'),
                            //       value: 42,
                            //     ),
                            //   ],
                            //   onChanged: (v) {
                            //     setState(() {
                            //       _value = v;
                            //     });
                            //   },
                            // );
                          },
                          child: SvgPicture.asset("assets/svg/drop_button.svg"))
                      // child: SvgPicture.asset("assets/svg/drop_button.svg"))
                    ],
                  ),
                  CommonSizeBox.commonSizeBox(height: Get.height * 0.03),
                  Container(
                    height: Get.height * 0.4,
                    width: Get.width,
                    child: ListView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            child: Container(
                              height: Get.height * 0.09,
                              // color: Colors.orange,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  '${images[index]}'),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle),
                                      height: 34.sp,
                                      width: 34.sp,
                                    ),
                                    CommonSizeBox.commonSizeBox(
                                        width: Get.width * 0.04),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CommonText.textSemiBoldDynamicP(
                                            text: "Dale McDaniel",
                                            textColor: ColorPicker.whiteColor),
                                        index.isOdd
                                            ? SvgPicture.asset(
                                                "assets/svg/small_call_button.svg")
                                            : SvgPicture.asset(
                                                "assets/svg/small_video_button.svg")
                                      ],
                                    ),
                                    CommonSizeBox.commonSizeBox(
                                        width: Get.width * 0.2),
                                    index.isEven
                                        ? CommonText.textSemiBoldDynamicP(
                                            text: "+ £5.86",

                                            ///green
                                            textColor: Color(0xff1DC7AC),

                                            ///red
                                            // textColor: Color(0xffFE4A54),
                                            fontSize: 13.sp)
                                        : CommonText.textSemiBoldDynamicP(
                                            text: "+ £5.86",

                                            ///green
                                            // textColor: Color(0xff1DC7AC),

                                            ///red
                                            textColor: Color(0xffFE4A54),
                                            fontSize: 13.sp),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: ColorPicker.themBlackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Spacer(),
                  SvgPicture.asset("assets/svg/squear-svgrepo-com.svg"),
                  CommonSizeBox.commonSizeBox(width: 8),
                  SvgPicture.asset("assets/svg/setting_iocn_d.svg")
                ],
              ),
            ),
            CommonSizeBox.commonSizeBox(height: Get.height * 0.05),
            GetBuilder<GetBalanceViewModel>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.textMediumDynamicColor400(
                      text: "Your Current Balance",
                      textColor: ColorPicker.hintTextColor,
                    ),
                    CommonText.textSemiBoldDynamicP(
                        text: controller.valueUsd == ''
                            ? 'Loading....'
                            : '${double.parse((_getBalanceViewModel.valueUsd)).toStringAsFixed(10).toString()} £',
                        // : '${double.parse((controller.valueUsd).toStringAsFixed(2).toString())}',
                        textColor: ColorPicker.whiteColor,
                        fontSize: 20.sp),
                    CommonText.textSemiBoldDynamicP(
                        text: "",
                        textColor: ColorPicker.whiteColor,
                        fontSize: 14.sp),
                    CommonSizeBox.commonSizeBox(height: Get.height * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            height: Get.height * 0.065,
                            width: Get.width * 0.42,
                            decoration: BoxDecoration(
                                // color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xff777794), width: 2)),
                            child: Center(
                                child: CommonText.textSemiBoldDynamicP(
                                    text: "Buy Bitcoin",
                                    textColor: ColorPicker.whiteColor,
                                    fontSize: 12.sp)),
                          ),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Container(
                            height: Get.height * 0.065,
                            width: Get.width * 0.42,
                            decoration: BoxDecoration(
                                // color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xff777794), width: 2)),
                            child: Center(
                                child: CommonText.textSemiBoldDynamicP(
                                    text: "Make a payment",
                                    textColor: ColorPicker.whiteColor,
                                    fontSize: 12.sp)),
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
