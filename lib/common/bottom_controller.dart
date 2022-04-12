import 'package:consultancy/ViewModel/calling_screen_controller.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxString _selectedScreen = ''.obs;
  RxString get selectedScreen => _selectedScreen;
  void setIndex(int? id) {
    bottomIndex.value = id!;
    update();
  }

  void setSelectedScreen(String value) {
    _selectedScreen.value = value;
    update();
  }

  RxBool isRingtone = false.obs;
  RxBool isCallCutter = false.obs;
  void onInit() {
    bottomIndex.value = 3;
    setSelectedScreen('UserHomeWidget');
  }
}
