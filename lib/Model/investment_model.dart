// To parse this JSON data, do
//
//     final investModel = investModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InvestModel investModelFromJson(String str) =>
    InvestModel.fromJson(json.decode(str));

String investModelToJson(InvestModel data) => json.encode(data.toJson());

class InvestModel {
  InvestModel({
    required this.status,
    required this.data,
  });

  bool status;
  List<InvestmentModel>? data;

  factory InvestModel.fromJson(Map<String, dynamic> json) => InvestModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<InvestmentModel>.from(
                json["data"].map((x) => InvestmentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class InvestmentModel {
  InvestmentModel({
    required this.planId,
    required this.planName,
    required this.planPrice,
    required this.planDescription,
    required this.planPeriod,
    required this.planDailyGains,
    required this.planGainsDescription,
    required this.planStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.totalGain,
    required this.paragrapf,
  });

  String planId;
  String planName;
  String planPrice;
  String planDescription;
  String planPeriod;
  String planDailyGains;
  String planGainsDescription;
  String planStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  var totalGain;
  String? paragrapf;

  factory InvestmentModel.fromJson(Map<String, dynamic> json) =>
      InvestmentModel(
        planId: json["plan_id"] == null ? null : json["plan_id"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planPrice: json["plan_price"] == null ? null : json["plan_price"],
        planDescription:
            json["plan_description"] == null ? null : json["plan_description"],
        planPeriod: json["plan_period"] == null ? null : json["plan_period"],
        planDailyGains:
            json["plan_daily_gains"] == null ? null : json["plan_daily_gains"],
        planGainsDescription: json["plan_gains_description"] == null
            ? null
            : json["plan_gains_description"],
        planStatus: json["plan_status"] == null ? null : json["plan_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalGain: json["total_gain"] == null ? null : json["total_gain"],
        paragrapf: json["paragraph"] == null ? null : json["paragraph"],
      );

  Map<String, dynamic> toJson() => {
        "plan_id": planId == null ? null : planId,
        "plan_name": planName == null ? null : planName,
        "plan_price": planPrice == null ? null : planPrice,
        "plan_description": planDescription == null ? null : planDescription,
        "plan_period": planPeriod == null ? null : planPeriod,
        "plan_daily_gains": planDailyGains == null ? null : planDailyGains,
        "plan_gains_description":
            planGainsDescription == null ? null : planGainsDescription,
        "plan_status": planStatus == null ? null : planStatus,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "total_gain": totalGain == null ? null : totalGain,
        "paragrapf": paragrapf == null ? null : paragrapf,
      };
}
