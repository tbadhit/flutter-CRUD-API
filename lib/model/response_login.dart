// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.pesan,
    required this.sukses,
    required this.userData,
  });

  String pesan;
  bool sukses;
  UserData userData;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        pesan: json["pesan"],
        sukses: json["sukses"],
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "pesan": pesan,
        "sukses": sukses,
        "user_data": userData.toJson(),
      };
}

class UserData {
  UserData({
    this.userId,
    this.userNama,
    this.userEmail,
    this.userHp,
    this.userPassword,
    this.userStatus,
  });

  String? userId;
  String? userNama;
  String? userEmail;
  String? userHp;
  String? userPassword;
  String? userStatus;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"],
        userNama: json["user_nama"],
        userEmail: json["user_email"],
        userHp: json["user_hp"],
        userPassword: json["user_password"],
        userStatus: json["user_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_nama": userNama,
        "user_email": userEmail,
        "user_hp": userHp,
        "user_password": userPassword,
        "user_status": userStatus,
      };
}
