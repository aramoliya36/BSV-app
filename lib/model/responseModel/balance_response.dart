// To parse this JSON data, do
//
//     final balanceResponse = balanceResponseFromJson(jsonString);

import 'dart:convert';

BalanceResponse balanceResponseFromJson(String str) =>
    BalanceResponse.fromJson(json.decode(str));

String balanceResponseToJson(BalanceResponse data) =>
    json.encode(data.toJson());

class BalanceResponse {
  BalanceResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      BalanceResponse(
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
    this.totalBalance,
    this.coins,
  });

  String? status;
  String? msg;
  TotalBalance? totalBalance;
  List<Coin>? coins;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
        totalBalance: TotalBalance.fromJson(json["totalBalance"]),
        coins: List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "totalBalance": totalBalance!.toJson(),
        "coins": List<dynamic>.from(coins!.map((x) => x.toJson())),
      };
}

class Coin {
  Coin({
    this.protocol,
    this.balance,
  });

  String? protocol;
  dynamic balance;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        protocol: json["protocol"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "protocol": protocol,
        "balance": balance,
      };
}

class TotalBalance {
  TotalBalance({
    this.currency,
    this.balance,
  });

  String? currency;
  dynamic balance;

  factory TotalBalance.fromJson(Map<String, dynamic> json) => TotalBalance(
        currency: json["currency"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "balance": balance,
      };
}
