import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy/ViewModel/schedule_viewmodel.dart';
import 'package:consultancy/common/bottom_controller.dart';
import 'package:consultancy/common/preference_manager.dart';
import 'package:consultancy/common/size_box.dart';
import 'package:consultancy/model/responseModel/user_data_responsemodel.dart';
import 'package:consultancy/res/Colors/colors_class.dart';
import 'package:consultancy/res/text/text_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? _userMap;
  bool _searchClicked = false;
  GetPrefResponse? _chatUserList;
  GetPrefResponse? _res;
  BottomController _bottomController = Get.find();
  TextEditingController _searchController = TextEditingController();
  ScheduleViewModel _scheduleViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SingleChildScrollView(
        child: Material(
          color: ColorPicker.themBlackColor,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.sp),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30.sp,
                    decoration: BoxDecoration(
                      color: ColorPicker.searchBarColor,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        print(
                            '---------is+   ${_searchController.text.startsWith('+')}');
                        setState(() {});
                      },
                      style: TextStyle(
                          color: ColorPicker.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                      cursorColor: ColorPicker.whiteColor,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 1.sp),
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorPicker.whiteColor,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: ColorPicker.whiteColor),
                          border: InputBorder.none),
                    ),
                  ),
                  _searchController.text.isNotEmpty
                      ? StreamBuilder(
                          stream: _searchController.text.startsWith('+')
                              ? FirebaseFirestore.instance
                                  .collection('UserAllData')
                                  .where("handle_small_name",
                                      isGreaterThanOrEqualTo:
                                          _searchController.text.toLowerCase())
                                  .where('handle_small_name',
                                      isNotEqualTo: PreferenceManager
                                          .getNotSearchHandel())
                                  .snapshots()
                              : FirebaseFirestore.instance
                                  .collection('UserAllData')
                                  .where("search_small_name",
                                      isGreaterThanOrEqualTo:
                                          _searchController.text.toLowerCase())
                                  .where('search_small_name',
                                      isNotEqualTo:
                                          PreferenceManager.getNotSearchName())
                                  .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!.docs.isNotEmpty
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        // print(
                                        //     '----------- ${snapshot.data!.docs[index]['name']}');
                                        var m = snapshot.data!.docs[index];

                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: InkWell(
                                            onTap: () {
                                              _scheduleViewModel.nameProfile =
                                                  snapshot.data!.docs[index]
                                                      ['name'];
                                              _scheduleViewModel.imageUser =
                                                  snapshot.data!.docs[index]
                                                      ['userImage'];
                                              _scheduleViewModel.userData =
                                                  snapshot.data!.docs[index];
                                              // Get.offAll(ProfileNew());
                                              _bottomController
                                                  .selectedScreen('ProfileNew');
                                              _bottomController
                                                  .bottomIndex.value = 3;
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  'userImage']),
                                                          fit: BoxFit.cover),
                                                      shape: BoxShape.circle),
                                                  height: 34.sp,
                                                  width: 34.sp,
                                                ),
                                                CommonSizeBox.commonSizeBox(
                                                    width: 8.sp),
                                                CommonText.textRegularW400(
                                                    text: snapshot.data!
                                                        .docs[index]['name']),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : SizedBox();
                            } else {
                              return SizedBox();
                            }
                          },
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {
        _bottomController.selectedScreen('UserHomeWidget');
        _bottomController.bottomIndex.value = 3;
        return Future.value(false);
      },
    );
  }

  fetchData() async {
    var userFetchData = FirebaseFirestore.instance
        .collection('UserAllData')
        .where("name", isGreaterThanOrEqualTo: _searchController.text)
        .get();
    // .where("name", isEqualTo: 'milanAmreliya');
    // var querySnapshot = await userFetchData.get();
    //  for (var queryDocumentSnapshot in querySnapshot.docs) {
    //    Map<String, dynamic> data = queryDocumentSnapshot.data();
    //    print('------------1 ${data['name']}');
    //    GetPrefResponse _res = GetPrefResponse.fromJson(data);
    //    print('----_res.name--------- ${_res}');
    //  }

    return userFetchData;
  }
}
