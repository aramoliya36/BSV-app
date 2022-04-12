import 'package:consultancy/model/apis/api_response.dart';
import 'package:consultancy/model/repo/get_address_id_repo.dart';
import 'package:consultancy/model/responseModel/get_address_id_responsemodle.dart';
import 'package:get/get.dart';

class GetAddressIdTraViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future getAddressIdTraViewModel({Map<String, String>? header}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetAddressIdResponse response =
          await AddressIdTraRepo().addressIdTraRepo(header: header);
      print('trsp===GetAddressIdTraViewModel=>$response');
      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("....GetAddressIdTraViewModel.....>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
