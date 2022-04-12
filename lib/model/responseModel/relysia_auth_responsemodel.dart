// To parse this JSON data, do
//
//     final relaysiaAuthResponse = relaysiaAuthResponseFromJson(jsonString);

import 'dart:convert';

RelaysiaAuthResponse relaysiaAuthResponseFromJson(String str) =>
    RelaysiaAuthResponse.fromJson(json.decode(str));

String relaysiaAuthResponseToJson(RelaysiaAuthResponse data) =>
    json.encode(data.toJson());

class RelaysiaAuthResponse {
  RelaysiaAuthResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory RelaysiaAuthResponse.fromJson(Map<String, dynamic> json) =>
      RelaysiaAuthResponse(
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
    this.token,
  });

  String? status;
  String? msg;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "token": token,
      };
}
