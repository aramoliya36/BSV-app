import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  File? profileImage;
  final picker = ImagePicker();

  setProfileImage({File? value}) {
    profileImage = value;
    update();
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    if (imaGe != null) {
      profileImage = File(imaGe.path);
      print("=======================imagepathe${imaGe.path}");
      imageCache!.clear();
      // profileImage.clear();
    } else {
      print('no image selected');
    }
    //  });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("=======================imagepathe${imaGe!.path}");

    //  setState(() {
    if (imaGe != null) {
      profileImage = File(imaGe.path);
      print("=======================imagepathe${profileImage}");
      print("=======================imagepathe${imaGe.path}");
      imageCache!.clear();
    } else {
      print('no image selected');
    }
    // });
  }
}
