import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/get_balance_repo.dart';
import 'package:consultancy/model/responseModel/balance_response.dart';
import 'package:get/get.dart';

class GetBalanceViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> getBalanceViewModel({Map<String, String>? header}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      BalanceResponse response =
          await GetBalanceRepo().getBalanceRepo(header: header);
      print('trsp===GetBalanceViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetBalanceViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  String _valueUsd = '';

  String get valueUsd => _valueUsd;

  set valueUsd(String value) {
    _valueUsd = value;
    update();
  }
}
