// To parse this JSON data, do
//
//     final getAddressIdResponse = getAddressIdResponseFromJson(jsonString);

import 'dart:convert';

GetAddressIdResponse getAddressIdResponseFromJson(String str) =>
    GetAddressIdResponse.fromJson(json.decode(str));

String getAddressIdResponseToJson(GetAddressIdResponse data) =>
    json.encode(data.toJson());

class GetAddressIdResponse {
  GetAddressIdResponse({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory GetAddressIdResponse.fromJson(Map<String, dynamic> json) =>
      GetAddressIdResponse(
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
    this.address,
    this.paymail,
  });

  String? status;
  String? msg;
  String? address;
  String? paymail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        msg: json["msg"],
        address: json["address"],
        paymail: json["paymail"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "address": address,
        "paymail": paymail,
      };
}
