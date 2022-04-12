import 'package:get/get.dart';

class CountryPickChangeMobileViewModel extends GetxController {
  bool _showLoading = false;

  bool get showLoading => _showLoading;

  set showLoading(bool value) {
    _showLoading = value;
    update();
  }
}
