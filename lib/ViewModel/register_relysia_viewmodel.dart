import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
import 'package:get/get.dart';

class AddToCartViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> addToCartViewModel({RegisterRelasiyaReqModel? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      // AddToCartResponse response =
      //     await AddToCartRepo().addToCartRepo(model.toJson());
      // print('trsp===AddToCartViewModel=>$response');
      // _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....AddToCartViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
