// To parse this JSON data, do
//
//     final teamReportModel = teamReportModelFromJson(jsonString);

import 'dart:convert';

TeamReportModel teamReportModelFromJson(String str) =>
    TeamReportModel.fromJson(json.decode(str));

String teamReportModelToJson(TeamReportModel data) =>
    json.encode(data.toJson());

class TeamReportModel {
  TeamReportModel({
    required this.status,
    required this.data,
    required this.message,
  });

  bool status;
  TeamReportData data;
  String message;

  factory TeamReportModel.fromJson(Map<String, dynamic> json) =>
      TeamReportModel(
        status: json["status"],
        data: TeamReportData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class TeamReportData {
  TeamReportData({
    required this.teamBalance,
    required this.teamTopUp,
    required this.teamWithdrawl,
    required this.yourTeam,
    required this.successfullReferrals,
    required this.level1,
    required this.level2,
    required this.level3,
  });

  int teamBalance;
  int teamTopUp;
  int teamWithdrawl;
  int yourTeam;
  int successfullReferrals;
  List<Level1> level1;
  List<dynamic> level2;
  List<dynamic> level3;

  factory TeamReportData.fromJson(Map<String, dynamic> json) => TeamReportData(
        teamBalance: json["team-balance"],
        teamTopUp: json["team-top-up"],
        teamWithdrawl: json["team-withdrawl"],
        yourTeam: json["your-team"],
        successfullReferrals: json["successfull-referrals"],
        level1:
            List<Level1>.from(json["level-1"].map((x) => Level1.fromJson(x))),
        level2: List<dynamic>.from(json["level-2"].map((x) => x)),
        level3: List<dynamic>.from(json["level-3"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "team-balance": teamBalance,
        "team-top-up": teamTopUp,
        "team-withdrawl": teamWithdrawl,
        "your-team": yourTeam,
        "successfull-referrals": successfullReferrals,
        "level-1": List<dynamic>.from(level1.map((x) => x.toJson())),
        "level-2": List<dynamic>.from(level2.map((x) => x)),
        "level-3": List<dynamic>.from(level3.map((x) => x)),
      };
}

class Level1 {
  Level1({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.level,
    required this.balance,
    required this.topUp,
  });

  String userId;
  String name;
  dynamic email;
  String phone;
  String level;
  dynamic balance;
  dynamic topUp;

  factory Level1.fromJson(Map<String, dynamic> json) => Level1(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        level: json["level"],
        balance: json["balance"],
        topUp: json["top_up"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "level": level,
        "balance": balance,
        "top_up": topUp,
      };
}
class Level2 {
  Level2({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.level,
    required this.balance,
    required this.topUp,
  });

  String userId;
  String name;
  dynamic email;
  String phone;
  String level;
  String balance;
  dynamic topUp;

  factory Level2.fromJson(Map<String, dynamic> json) => Level2(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        level: json["level"],
        balance: json["balance"],
        topUp: json["top_up"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "level": level,
        "balance": balance,
        "top_up": topUp,
      };
}
