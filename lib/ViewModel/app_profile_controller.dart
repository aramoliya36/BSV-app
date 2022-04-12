import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AppProfileController extends GetxController {
  File? profileImage;
  final picker = ImagePicker();

  setProfileImage({File? value}) {
    profileImage = value;
    update();
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);

    if (imaGe != null) {
      profileImage = File(imaGe.path);
      imageCache!.clear();
    } else {
      print('no image selected');
    }
    //  });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);

    //  setState(() {
    if (imaGe != null) {
      profileImage = File(imaGe.path);
      imageCache!.clear();
    } else {
      print('no image selected');
    }
    // });
  }

  String? _byDefaultCurrency = '';

  String get byDefaultCurrency => _byDefaultCurrency!;

  set byDefaultCurrency(String value) {
    _byDefaultCurrency = value;
    update();
  }
}
