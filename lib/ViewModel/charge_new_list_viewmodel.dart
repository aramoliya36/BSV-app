import 'package:get/get.dart';

class ChargeListViewModel extends GetxController {
  bool _isDro = false;

  bool get isDro => _isDro;

  setIsDro() {
    _isDro = !_isDro;
    update();
  }

  String _selectVale = '';

  String get selectVale => _selectVale;

  set selectVale(String value) {
    _selectVale = value;
    update();
  }
}
