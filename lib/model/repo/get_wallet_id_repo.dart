import 'dart:developer';

import 'package:consultancy/model/responseModel/get_wallet_id.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class GetWalletIdRepo extends BaseService {
  Future<GetWalletIdResponse> getWalletIdRepo({
    Map<String, String>? header,
  }) async {
    var response = await APIService().getResponse(
        url: getWalletIdURL, apitype: APIType.aGet, header: header);
    log('----------GetWalletIdRepo---------$response');

    GetWalletIdResponse getWalletIdResponse =
        GetWalletIdResponse.fromJson(response);
    return getWalletIdResponse;
  }
}
