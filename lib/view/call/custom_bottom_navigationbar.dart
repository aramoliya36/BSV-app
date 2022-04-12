import 'package:consultancy/common/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomNavigatoinBarwidget extends StatefulWidget {
  const CustomNavigatoinBarwidget({Key? key}) : super(key: key);

  @override
  _CustomNavigatoinBarwidgetState createState() =>
      _CustomNavigatoinBarwidgetState();
}

class _CustomNavigatoinBarwidgetState extends State<CustomNavigatoinBarwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff777794),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon:
                      CommonWidget.svgPicture(image: 'assets/svg/speckar.svg'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CommonWidget.svgPicture(
                      image: 'assets/svg/vedio_call.svg'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: CommonWidget.svgPicture(
                      image: 'assets/svg/micro_phone.svg'),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 34.sp,
                    width: 34.sp,
                    child: SvgPicture.asset(
                      'assets/svg/call_cut_icon.svg',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomBottomSheetPage(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50.0)),
      ),
      context: context,
      builder: (builder) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: Get.height * 0.4,
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_up,
                      color: Color(0xffffffff),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.video_call_outlined,
                      color: Color(0xffffffff),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.keyboard_voice_sharp,
                      color: Color(0xffffffff),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.red,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.phone_missed_outlined,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: Color(0xff9D9DBE),
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.person_add,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Add participant',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: Color(0xff9D9DBE),
                          width: 50,
                          height: 50,
                          child: const Icon(
                            Icons.person_add,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Add participant',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xff777794),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(50.0))),
        );
      },
    );
  }
}
