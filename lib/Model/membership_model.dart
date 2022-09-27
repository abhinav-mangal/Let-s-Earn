// To parse this JSON data, do
//
//     final membership = membershipFromJson(jsonString);

import 'dart:convert';

MembershipModel membershipFromJson(String str) => MembershipModel.fromJson(json.decode(str));

String membershipToJson(MembershipModel data) => json.encode(data.toJson());

class MembershipModel {
    MembershipModel({
        required this.status,
        required this.data,
        required this.message,
    });

    bool status;
    List<MembershipData> data;
    String message;

    factory MembershipModel.fromJson(Map<String, dynamic> json) => MembershipModel(
        status: json["status"],
        data: List<MembershipData>.from(json["data"].map((x) => MembershipData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class MembershipData {
    MembershipData({
        required this.vipNo,
        required this.price,
        required this.dailyMission,
        required this.validity,
        required this.missionCommission,
        required this.dailyIncome,
    });

    String vipNo;
    String price;
    String dailyMission;
    String validity;
    String missionCommission;
    String dailyIncome;

    factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
        vipNo: json["vip-no"],
        price: json["price"],
        dailyMission: json["daily-mission"],
        validity: json["validity"],
        missionCommission: json["mission-commission"],
        dailyIncome: json["daily-income"],
    );

    Map<String, dynamic> toJson() => {
        "vip-no": vipNo,
        "price": price,
        "daily-mission": dailyMission,
        "validity": validity,
        "mission-commission": missionCommission,
        "daily-income": dailyIncome,
    };
}
