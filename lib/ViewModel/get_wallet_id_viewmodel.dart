import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/get_wallet_id_repo.dart';
import 'package:consultancy/model/responseModel/get_wallet_id.dart';
import 'package:get/get.dart';

class GetWalletIdViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future getWalletIdViewModel({Map<String, String>? header}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetWalletIdResponse response =
          await GetWalletIdRepo().getWalletIdRepo(header: header);
      print('trsp===GetWalletIdViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetWalletIdViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
