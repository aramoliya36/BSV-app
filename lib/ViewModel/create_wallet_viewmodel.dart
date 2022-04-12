import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/create_wallet_repo.dart';
import 'package:consultancy/model/repo/get_address_id_repo.dart';
import 'package:consultancy/model/responseModel/create_wallet_response.dart';
import 'package:consultancy/model/responseModel/get_address_id_responsemodle.dart';
import 'package:get/get.dart';

class CreateWalletViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future createWalletViewModel({Map<String, String>? header}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CreateWalletResponse response =
          await CreateWalletRepo().createWalletRepo(header: header);
      print('trsp===CreateWalletViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....CreateWalletViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
