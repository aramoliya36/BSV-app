import 'dart:convert';

import 'package:consultancy/model/responseModel/agora_token_response.dart';
import 'package:http/http.dart' as http;

class AgoraTokenApiRepo {
  static agoraTokenApiRepo() async {
    var response = await http
        .post(Uri.parse(''), body: {'channelName': '${DateTime.now()}'});
    var data = jsonDecode(response.body);
    // print('-------agora data $data');
    if (data['response'] == 1 && response.statusCode == 200) {
      // print('-----agora token message ${data['TokenUId']}');
      AgoraTokenResponse _agoraTokenResponse =
          AgoraTokenResponse.fromJson(data);

      return _agoraTokenResponse;
    } else {
      print('-----agora token message ${data['message']}');
      return data['message'];
    }
  }
}
