// To parse this JSON data, do
//
//     final widhrawalRecordModel = widhrawalRecordModelFromJson(jsonString);

import 'dart:convert';

WidhrawalRecordModel widhrawalRecordModelFromJson(String str) =>
    WidhrawalRecordModel.fromJson(json.decode(str));

String widhrawalRecordModelToJson(WidhrawalRecordModel data) =>
    json.encode(data.toJson());

class WidhrawalRecordModel {
  WidhrawalRecordModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<WidhrawalRecordData>? data;
  String? message;

  factory WidhrawalRecordModel.fromJson(Map<String, dynamic> json) =>
      WidhrawalRecordModel(
        status: json["status"],
        data: List<WidhrawalRecordData>.from(json["data"].map((x) => WidhrawalRecordData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class WidhrawalRecordData {
  WidhrawalRecordData({
    this.createdAt,
    this.approvedStatus,
    this.transactionAmount,
  });

  String? createdAt;
  String? approvedStatus;
  String? transactionAmount;

  factory WidhrawalRecordData.fromJson(Map<String, dynamic> json) => WidhrawalRecordData(
        createdAt: json["created_at"],
        approvedStatus: json["approved_status"],
        transactionAmount: json["transaction_amount"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "approved_status": approvedStatus,
        "transaction_amount": transactionAmount,
      };
}
