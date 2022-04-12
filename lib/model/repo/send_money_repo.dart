import 'dart:convert';
import 'dart:developer';

import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/model/responseModel/send_money_response.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class SendMoneyRepo extends BaseService {
  Future<SendMoneyResponse> sendMoneyRepo({
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    var response = await APIService().getResponse(
        url: sendURL, body: body, apitype: APIType.aPost, header: header);
    log('----------SendMoneyRepo---------$response');

    SendMoneyResponse sendMoneyResponse = SendMoneyResponse.fromJson(response);
    return sendMoneyResponse;
  }
}
