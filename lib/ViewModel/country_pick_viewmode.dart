import 'package:get/get.dart';

class CountryPickViewModel extends GetxController {
  String _isDropMenu = '';

  String get isDropMenu => _isDropMenu;

  set isDropMenu(v) {
    _isDropMenu = v;
    update();
  }

  String _countryCode = '';

  String get countryCode => _countryCode;

  set countryCode(String value) {
    _countryCode = value;
    update();
  }
}
