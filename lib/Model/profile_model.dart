// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.balance,
    this.message,
    this.url,
  });

  bool? status;
  List<ProfileBalance>? balance;
  String? message;
  String? url;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        balance: List<ProfileBalance>.from(
            json["data"].map((x) => ProfileBalance.fromJson(x))),
        message: json["message"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "balance": List<dynamic>.from(balance!.map((x) => x.toJson())),
        "message": message,
      };
}

class ProfileBalance {
  ProfileBalance({
    this.name,
    this.email,
    this.phone,
    this.referralCode,
    this.balance,
    this.level,
    this.vipPurchased,
    this.avatar,
    this.expiryDate,
  });

  String? name;
  String? email;
  String? phone;
  String? referralCode;
  String? balance;
  String? level;
  DateTime? vipPurchased;
  String? avatar;
  String? expiryDate;

  factory ProfileBalance.fromJson(Map<String, dynamic> json) => ProfileBalance(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        referralCode: json["referral_code"],
        balance: json["balance"],
        level: json["level"],
        vipPurchased: DateTime.parse(json["vip_purchased"]),
        avatar: json["avatar"],
        expiryDate: json["expiry_date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "referral_code": referralCode,
        "balance": balance,
        "level": level,
        "vip_purchased": vipPurchased!.toIso8601String(),
        "avatar": avatar,
        "expiry_date": expiryDate,
      };
}
