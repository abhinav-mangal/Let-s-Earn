// To parse this JSON data, do
//
//     final achievementsModel = achievementsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AchievementsModel achievementsModelFromJson(String str) => AchievementsModel.fromJson(json.decode(str));

String achievementsModelToJson(AchievementsModel data) => json.encode(data.toJson());

class AchievementsModel {
    AchievementsModel({
        required this.status,
        required this.data,
        required this.totalUser,
        required this.message,
    });

    bool status;
    List<AchievementsList>? data;
    int totalUser;
    String message;

    factory AchievementsModel.fromJson(Map<String, dynamic> json) => AchievementsModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<AchievementsList>.from(json["data"].map((x) => AchievementsList.fromJson(x))),
        totalUser: json["total-user"] == null ? null : json["total-user"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total-user": totalUser == null ? null : totalUser,
        "message": message == null ? null : message,
    };
}

class AchievementsList {
    AchievementsList({
        required this.vipNo,
        required this.name,
        required this.amount,
        required this.image,
    });

    int vipNo;
    String name;
    String amount;
    String image;

    factory AchievementsList.fromJson(Map<String, dynamic> json) => AchievementsList(
        vipNo: json["vip-no"] == null ? null : json["vip-no"],
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "vip-no": vipNo == null ? null : vipNo,
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "image": image == null ? null : image,
    };
}
