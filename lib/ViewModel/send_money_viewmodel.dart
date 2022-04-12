import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/send_money_repo.dart';
import 'package:consultancy/model/requestModel/send_money_req_model.dart';
import 'package:consultancy/model/responseModel/send_money_response.dart';
import 'package:get/get.dart';

class SendMoneyViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> sendMoneyViewModel(
      {Map<String, dynamic>? body, Map<String, String>? header}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SendMoneyResponse response =
          await SendMoneyRepo().sendMoneyRepo(body: body, header: header);
      print('trsp===SendMoneyViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....SendMoneyViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
