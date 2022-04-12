class UserAllDataRequest {
  String? authToken;
  String? description;
  String? priceAudio;
  String? priceMessage;
  String? priceVideo;
  String? walletId;
  bool? profileDetails;
  bool? isCharges;
  String? phone;
  String? email;
  String? about;
  String? userImage;
  String? name;
  String? online;
  String? chargesStart;
  String? paymentMode;
  String? isCalling;
  String? callerName;
  String? userName;
  String? callerAuthToken;
  String? searchSmallName;
  String? agoraToken;
  String? agoraChannelName;
  String? fcmToken;
  String? relysiaToken;
  String? isVideoCall;
  String? profession;
  String? handleName;
  String? handleSmallName;
  String? transactionId;
  String? relysiaWalletId;
  String? callerTransactionId;
  String? tellUsAbout;

  UserAllDataRequest(
      {this.authToken,
      this.description,
      this.priceAudio,
      this.priceMessage,
      this.priceVideo,
      this.walletId,
      this.isCharges,
      this.phone,
      this.email,
      this.about,
      this.userImage,
      this.online,
      this.name,
      this.callerName,
      this.paymentMode,
      this.chargesStart,
      this.isCalling,
      this.userName,
      this.callerAuthToken,
      this.agoraToken,
      this.agoraChannelName,
      this.relysiaToken,
      this.searchSmallName,
      this.isVideoCall,
      this.fcmToken,
      this.handleName,
      this.handleSmallName,
      this.relysiaWalletId,
      this.profession,
      this.callerTransactionId,
      this.transactionId,
      this.tellUsAbout,
      this.profileDetails});

  Map<String, dynamic> toJson() {
    return {
      "user_name": userName != null ? userName : '',
      "online": online != null ? online : false,
      "name": name != null ? name : '',
      "auth_Token": authToken != null ? authToken : '',
      "description": description != null ? description : '',
      "price_audio": priceAudio != null ? priceAudio : '0.0',
      "price_message": priceMessage != null ? priceMessage : '0.0',
      "charges_Start": chargesStart != null ? chargesStart : '0.0',
      "price_video": priceVideo != null ? priceVideo : '0.0',
      "wallet_id": walletId != null ? walletId : '',
      "isCharges": isCharges != null ? isCharges : false,
      "profileDetails": profileDetails != null ? profileDetails : false,
      "phone": phone != null ? phone : '',
      "email": email != null ? email : '',
      "about": about != null ? about : '',
      "userImage": userImage != null ? userImage : '',
      "payment_mode": paymentMode != null ? paymentMode : '',
      "isCalling": isCalling != null ? isCalling : false,
      "caller_name": callerName != null ? callerName : '',
      "caller_auth_token": callerAuthToken != null ? callerAuthToken : '',
      "search_small_name": searchSmallName != null ? searchSmallName : '',
      "agora_token": agoraToken != null ? agoraToken : '',
      "agora_channel_name": agoraChannelName != null ? agoraChannelName : '',
      "fcm_token": fcmToken != null ? fcmToken : '',
      "relysia_token": relysiaToken != null ? relysiaToken : '',
      "isVideoCall": isVideoCall != null ? isVideoCall : false,
      "isCallReceived": isVideoCall != null ? isVideoCall : false,
      "Profession": profession != null ? profession : '',
      "handle_small_name": handleSmallName != null ? handleSmallName : '',
      "tell_us_about": tellUsAbout != null ? tellUsAbout : '',
      "relysia_wallet_id": relysiaWalletId != null ? relysiaWalletId : '',
      "transaction_id": transactionId != null ? transactionId : '',
      "caller_transaction_id":
          callerTransactionId != null ? callerTransactionId : '',
    };
  }
}
