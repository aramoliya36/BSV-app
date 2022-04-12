// To parse this JSON data, do
//
//     final agoraTokenResponse = agoraTokenResponseFromJson(jsonString);

import 'dart:convert';

AgoraTokenResponse agoraTokenResponseFromJson(String str) =>
    AgoraTokenResponse.fromJson(json.decode(str));

String agoraTokenResponseToJson(AgoraTokenResponse data) =>
    json.encode(data.toJson());

class AgoraTokenResponse {
  AgoraTokenResponse({
    this.response,
    this.message,
    this.tokenUId,
    this.tokenAccount,
    this.channelName,
  });

  int? response;
  String? message;
  String? tokenUId;
  String? tokenAccount;
  String? channelName;

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) =>
      AgoraTokenResponse(
        response: json["response"],
        message: json["message"],
        tokenUId: json["TokenUId"],
        tokenAccount: json["TokenAccount"],
        channelName: json["channelName"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "TokenUId": tokenUId,
        "TokenAccount": tokenAccount,
        "channelName": channelName,
      };
}
