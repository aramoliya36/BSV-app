// To parse this JSON data, do
//
//     final getWalletIdResponse = getWalletIdResponseFromJson(jsonString);

import 'dart:convert';

GetWalletIdResponse getWalletIdResponseFromJson(String str) =>
    GetWalletIdResponse.fromJson(json.decode(str));

String getWalletIdResponseToJson(GetWalletIdResponse data) =>
    json.encode(data.toJson());

class GetWalletIdResponse {
  GetWalletIdResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory GetWalletIdResponse.fromJson(Map<String, dynamic> json) =>
      GetWalletIdResponse(
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
    this.wallets,
  });

  String? status;
  String? msg;
  List<Wallet>? wallets;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
        wallets:
            List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "wallets": List<dynamic>.from(wallets!.map((x) => x.toJson())),
      };
}

class Wallet {
  Wallet({
    this.walletId,
    this.walletTitle,
    this.walletLogo,
  });

  String? walletId;
  String? walletTitle;
  dynamic walletLogo;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletId: json["walletID"],
        walletTitle: json["walletTitle"],
        walletLogo: json["walletLogo"],
      );

  Map<String, dynamic> toJson() => {
        "walletID": walletId,
        "walletTitle": walletTitle,
        "walletLogo": walletLogo,
      };
}
