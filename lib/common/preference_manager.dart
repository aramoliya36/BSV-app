import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///fcm token
  static Future setFcmToken(String fcmToken) async {
    await getStorage.write("fcm_token", fcmToken);
  }

  static getFcmToken() {
    return getStorage.read("fcm_token");
  }

  ///

  static Future setTokenId(String value) async {
    await getStorage.write("User_id", value);
  }

  static getTokenId() {
    return getStorage.read("User_id");
  }

  ///fname

  static Future setFnameId(String value) async {
    await getStorage.write("fName", value);
  }

  static getFnameId() {
    return getStorage.read("fName");
  }

  ///Lname

  static Future setLnameId(String value) async {
    await getStorage.write("lName", value);
  }

  static getLnameId() {
    return getStorage.read("lName");
  }

  ///Lname

  static Future setEmailId(String value) async {
    await getStorage.write("Email", value);
  }

  static getEmailId() {
    return getStorage.read("Email");
  }

  ///image

  static Future setImage(String value) async {
    await getStorage.write("image", value);
  }

  static getImage() {
    return getStorage.read("image");
  }

  /// not search
  static Future setNotSearchName(String value) async {
    await getStorage.write("search", value);
  }

  static getNotSearchName() {
    return getStorage.read("search");
  }

  /// not search + handel
  static Future setNotSearchHandel(String value) async {
    await getStorage.write("Handel", value);
  }

  static getNotSearchHandel() {
    return getStorage.read("Handel");
  }

  /// not relysia tokan
  static Future setRelasiyaToken(String value) async {
    await getStorage.write("RelasiyaToken", value);
  }

  static getRelasiyaToken() {
    return getStorage.read("RelasiyaToken");
  }

  /// not walletId tokan
  static Future setWalletId(String value) async {
    await getStorage.write("walletId", value);
  }

  static getWalletId() {
    return getStorage.read("walletId");
  }

  /// isLogin type
  static Future setLoginType(String value) async {
    //google
    //email
    //mobile
    await getStorage.write("isLoginType", value);
  }

  static getLoginType() {
    return getStorage.read("isLoginType");
  }

  /// Transfer id

  static Future setTransferId(String value) async {
    await getStorage.write("TransferId", value);
  }

  static getTransferId() {
    return getStorage.read("TransferId");
  }

  /// isLogin details
  static Future setLoginValue(String value) async {
    //google
    //email
    //mobile
    await getStorage.write("LoginValue", value);
  }

  static getLoginValue() {
    return getStorage.read("LoginValue");
  }

  /// store contact
  static Future setContact({List<Contact>? contactSave}) async {
    await getStorage.write("Contact", contactSave);
  }

  static getContact() {
    return getStorage.read("Contact");
  }
}
