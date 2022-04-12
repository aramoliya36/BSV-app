import 'package:get/get.dart';

class ScheduleViewModel extends GetxController {
  String _datePicker = '';

  String get datePicker => _datePicker;

  set datePicker(String value) {
    _datePicker = value;
    update();
  }

  String _nameProfile = '';

  String get nameProfile => _nameProfile;

  set nameProfile(String value) {
    _nameProfile = value;
    update();
  }

  String _imageUser = '';

  String get imageUser => _imageUser;

  set imageUser(String value) {
    _imageUser = value;
  }

  var _userData;

  get userData => _userData;

  set userData(value) {
    _userData = value;
  }

  DateTime? _dateTimeCall;

  DateTime get dateTimeCall => _dateTimeCall!;

  set dateTimeCall(DateTime value) {
    _dateTimeCall = value;
    update();
  }

  bool _isCallingMe = false;

  bool get isCallingMe => _isCallingMe;

  set isCallingMe(bool value) {
    _isCallingMe = value;
    update();
  }
}
