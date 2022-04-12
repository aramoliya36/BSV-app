class RegisterRelasiyaReqModel {
  String? emailOrPhone;
  String? password;

  RegisterRelasiyaReqModel({this.emailOrPhone, this.password});
  Map<String, dynamic> toJson() {
    return {
      "email": emailOrPhone,
      "password": password,
    };
  }
}
