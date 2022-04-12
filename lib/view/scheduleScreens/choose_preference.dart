import 'package:consultancy/common/common_widget.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sizer/sizer.dart';

import 'confirm_booking.dart';

class ChoosePreference extends StatefulWidget {
  const ChoosePreference({Key? key}) : super(key: key);

  @override
  _ChoosePreferenceState createState() => _ChoosePreferenceState();
}

class _ChoosePreferenceState extends State<ChoosePreference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRadio(),
    );
  }
}

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(true, '  Voice Call', '\$1.20 per min'));
    sampleData.add(new RadioModel(false, '  Video call', '\$3.40 per min'));
    sampleData.add(new RadioModel(false, '  Chat', 'Free'));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(FinalBooking());
        },
        child: CommonWidget.svgPicture(
          image: 'assets/svg/right_arrow.svg',
        ),
      ),
      backgroundColor: ColorPicker.themBlackColor,
      appBar: CommonWidget.appBarWithTitle(title: 'Choose Preference'),
      body: new ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            // splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: new RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      child: new Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.s,
        children: [
          Container(
            height: 25.0,
            width: 25.0,
            child: new Center(
              child: _item.isSelected
                  ? SvgPicture.asset(
                      'assets/svg/dort.svg',
                    )
                  : Container(),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.white : Colors.white,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.white : Colors.grey),
              shape: BoxShape.circle,
            ),
          ),
          CommonSizeBox.commonSizeBox(width: 10.sp),
          CommonText.textLargeP(text: _item.text),
          Spacer(),
          CommonText.textMediumDynamicColorP(
              text: _item.text1,
              textColor: ColorPicker.hintTextColor,
              textSize: 12.sp),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected = true;

  final String text;
  final String text1;

  RadioModel(this.isSelected, this.text, this.text1);
}
