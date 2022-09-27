// To parse this JSON data, do
//
//     final incomeExpendictureModel = incomeExpendictureModelFromJson(jsonString);

import 'dart:convert';

IncomeExpendictureModel incomeExpendictureModelFromJson(String str) => IncomeExpendictureModel.fromJson(json.decode(str));

String incomeExpendictureModelToJson(IncomeExpendictureModel data) => json.encode(data.toJson());

class IncomeExpendictureModel {
    IncomeExpendictureModel({
        this.status,
        this.data,
        this.message,
    });

    bool? status;
    List<IncomeExpendictureData>? data;
    String? message;

    factory IncomeExpendictureModel.fromJson(Map<String, dynamic> json) => IncomeExpendictureModel(
        status: json["status"],
        data: List<IncomeExpendictureData>.from(json["data"].map((x) => IncomeExpendictureData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class IncomeExpendictureData {
    IncomeExpendictureData({
        this.createdAt,
        this.transactionType,
        this.taskType,
        this.transactionAmount,
    });

    String ?createdAt;
    String? transactionType;
    String ?taskType;
    String ?transactionAmount;

    factory IncomeExpendictureData.fromJson(Map<String, dynamic> json) => IncomeExpendictureData(
        createdAt: json["created_at"],
        transactionType: json["transaction_type"],
        taskType: json["task_type"],
        transactionAmount: json["transaction_amount"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "transaction_type": transactionType,
        "task_type": taskType,
        "transaction_amount": transactionAmount,
    };
}
