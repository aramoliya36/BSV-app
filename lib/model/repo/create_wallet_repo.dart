import 'dart:developer';
import 'package:consultancy/model/responseModel/create_wallet_response.dart';
import 'package:consultancy/model/responseModel/get_address_id_responsemodle.dart';
import 'package:consultancy/model/services/api_service.dart';
import 'package:consultancy/model/services/base_service.dart';

class CreateWalletRepo extends BaseService {
  Future<CreateWalletResponse> createWalletRepo({
    Map<String, String>? header,
  }) async {
    var response = await APIService().getResponse(
        url: createWalletURL, apitype: APIType.aGet, header: header);
    log('----------CreateWalletRepo---------$response');

    CreateWalletResponse createWalletResponse =
        CreateWalletResponse.fromJson(response);
    print(
        '--------teWalletResponse.data!.walletId-------------${createWalletResponse.data!.walletId}');
    return createWalletResponse;
  }
}
