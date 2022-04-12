// To parse this JSON data, do
//
//     final createWalletResponse = createWalletResponseFromJson(jsonString);

import 'dart:convert';

CreateWalletResponse createWalletResponseFromJson(String str) =>
    CreateWalletResponse.fromJson(json.decode(str));

String createWalletResponseToJson(CreateWalletResponse data) =>
    json.encode(data.toJson());

class CreateWalletResponse {
  CreateWalletResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory CreateWalletResponse.fromJson(Map<String, dynamic> json) =>
      CreateWalletResponse(
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
    this.walletId,
  });

  String? status;
  String? msg;
  String? walletId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
        walletId: json["walletID"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "walletID": walletId,
      };
}
