import 'dart:convert';

GetPrefResponse getPrefResponseFromJson(String str) =>
    GetPrefResponse.fromJson(json.decode(str));

String getPrefResponseToJson(GetPrefResponse data) =>
    json.encode(data.toJson());

class GetPrefResponse {
  GetPrefResponse({
    this.getPrefResponseUserName,
    this.online,
    this.name,
    this.authToken,
    this.description,
    this.priceAudio,
    this.userName,
    this.priceMessage,
    this.chargesStart,
    this.priceVideo,
    this.walletId,
    this.isCharges,
    this.profileDetails,
    this.phone,
    this.email,
    this.about,
    this.userImage,
    this.paymentMode,
  });

  String? getPrefResponseUserName;
  bool? online;
  String? name;
  String? authToken;
  String? description;
  String? priceAudio;
  String? userName;
  String? priceMessage;
  String? chargesStart;
  String? priceVideo;
  String? walletId;
  bool? isCharges;
  bool? profileDetails;
  String? phone;
  String? email;
  String? about;
  String? userImage;
  String? paymentMode;

  factory GetPrefResponse.fromJson(Map<String, dynamic> json) =>
      GetPrefResponse(
        getPrefResponseUserName: json["user_name"],
        online: json["online"],
        name: json["name"],
        authToken: json["auth_Token"],
        description: json["description"],
        priceAudio: json["price_audio"],
        userName: json["userName"],
        priceMessage: json["price_message"],
        chargesStart: json["charges_Start"],
        priceVideo: json["price_video"],
        walletId: json["wallet_id"],
        isCharges: json["isCharges"],
        profileDetails: json["profileDetails"],
        phone: json["phone"],
        email: json["email"],
        about: json["about"],
        userImage: json["userImage"],
        paymentMode: json["payment_mode"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": getPrefResponseUserName,
        "online": online,
        "name": name,
        "auth_Token": authToken,
        "description": description,
        "price_audio": priceAudio,
        "userName": userName,
        "price_message": priceMessage,
        "charges_Start": chargesStart,
        "price_video": priceVideo,
        "wallet_id": walletId,
        "isCharges": isCharges,
        "profileDetails": profileDetails,
        "phone": phone,
        "email": email,
        "about": about,
        "userImage": userImage,
        "payment_mode": paymentMode,
      };
}
