import 'dart:developer';

import 'package:consultancy/model/responseModel/balance_response.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class GetBalanceRepo extends BaseService {
  Future<BalanceResponse> getBalanceRepo({
    Map<String, String>? header,
  }) async {
    var response = await APIService()
        .getResponse(url: getBalanceURL, apitype: APIType.aGet, header: header);
    log('----------GetBalanceRepo---------$response');

    BalanceResponse balanceResponse = BalanceResponse.fromJson(response);
    return balanceResponse;
  }
}
