import 'package:get/get.dart';

class OtpScreenController extends GetxController {
  bool _showLoading = false;

  bool get showLoading => _showLoading;

  set showLoading(bool value) {
    _showLoading = value;
    update();
  }
}
