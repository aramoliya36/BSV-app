import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  bool _isDropMenu = false;

  bool get isDropMenu => _isDropMenu;

  set isDropMenu(v) {
    _isDropMenu = !_isDropMenu;
    update();
  }
}
