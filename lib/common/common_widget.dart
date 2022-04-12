import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommonWidget {
  static SvgPicture svgPicture({required String image}) {
    return SvgPicture.asset(image);
  }

  static Padding rowTwoAppBarIcon(
      {String? image1, String? image2, dynamic onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 25),
      child: Row(
        children: [
          CommonWidget.svgPicture(
            image: image1!,
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
            child: CommonWidget.svgPicture(
              image: image2!,
            ),
          ),
        ],
      ),
    );
  }

  static AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: EdgeInsets.all(10),
        height: 10,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CommonWidget.svgPicture(
            image: 'assets/svg/back_icon.svg',
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  static AppBar appBarWithTitle({String? title}) {
    return AppBar(
      elevation: 0,
      title: CommonText.textBold700P(text: title!),
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: EdgeInsets.all(10),
        height: 10,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CommonWidget.svgPicture(
            image: 'assets/svg/back_icon.svg',
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  static AppBar appBarWithTitleBottom({String? title, dynamic function}) {
    return AppBar(
      elevation: 0,
      title: CommonText.textBold700P(text: title!),
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: EdgeInsets.all(10),
        height: 10,
        child: InkWell(
          onTap: function,
          child: CommonWidget.svgPicture(
            image: 'assets/svg/back_icon.svg',
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}
