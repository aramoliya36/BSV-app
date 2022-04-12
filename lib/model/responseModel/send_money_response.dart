// To parse this JSON data, do
//
//     final sendMoneyResponse = sendMoneyResponseFromJson(jsonString);

import 'dart:convert';

SendMoneyResponse sendMoneyResponseFromJson(String str) =>
    SendMoneyResponse.fromJson(json.decode(str));

String sendMoneyResponseToJson(SendMoneyResponse data) =>
    json.encode(data.toJson());

class SendMoneyResponse {
  SendMoneyResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) =>
      SendMoneyResponse(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.status,
    this.msg,
  });

  String? status;
  String? msg;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
