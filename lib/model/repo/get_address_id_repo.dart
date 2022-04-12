import 'dart:developer';

import 'package:consultancy/model/responseModel/balance_response.dart';
import 'package:consultancy/model/responseModel/get_address_id_responsemodle.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class AddressIdTraRepo extends BaseService {
  Future<GetAddressIdResponse> addressIdTraRepo({
    Map<String, String>? header,
  }) async {
    var response = await APIService()
        .getResponse(url: addressURL, apitype: APIType.aGet, header: header);
    log('----------AddressIdTraRepo---------$response');

    GetAddressIdResponse getAddressIdResponse =
        GetAddressIdResponse.fromJson(response);
    return getAddressIdResponse;
  }
}
