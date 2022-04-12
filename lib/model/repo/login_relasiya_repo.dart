import 'dart:convert';
import 'dart:developer';

import 'package:consultancy/model/responseModel/relysia_auth_responsemodel.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class RegisterRelysiaRepo extends BaseService {
  Future<RelaysiaAuthResponse> registerRelysiaRepo(
      {Map<String, dynamic>? body, required bool isLogin}) async {
    var response = await APIService().getResponse(
        url: isLogin ? loginRelasiyaURL : registerURL,
        body: body,
        // body: {'email': 'hjhjjhjh@gmail.com', 'password': '12345678'},
        apitype: APIType.aPost);
    RelaysiaAuthResponse relaysiaAuthResponse =
        RelaysiaAuthResponse.fromJson(response);
    return relaysiaAuthResponse;
    //{statusCode: 400, data: {status: error, msg: EMAIL_EXISTS}}
    //return addAddressResponse;
  }
}
