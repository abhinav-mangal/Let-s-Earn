// To parse this JSON data, do
//
//     final helpCentreModel = helpCentreModelFromJson(jsonString);

import 'dart:convert';

HelpCentreModel helpCentreModelFromJson(String str) =>
    HelpCentreModel.fromJson(json.decode(str));

String helpCentreModelToJson(HelpCentreModel data) =>
    json.encode(data.toJson());

class HelpCentreModel {
  HelpCentreModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  List<HelpCentreData>? data;
  String? message;

  factory HelpCentreModel.fromJson(Map<String, dynamic> json) =>
      HelpCentreModel(
        status: json["status"],
        data: List<HelpCentreData>.from(json["data"].map((x) => HelpCentreData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class HelpCentreData {
  HelpCentreData({
    this.helpId,
    this.question,
    this.answer,
    this.createdAt,
  });

  String? helpId;
  String? question;
  String? answer;
  DateTime? createdAt;

  factory HelpCentreData.fromJson(Map<String, dynamic> json) => HelpCentreData(
        helpId: json["help_id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "help_id": helpId,
        "question": question,
        "answer": answer,
        "created_at": createdAt!.toIso8601String(),
      };
}
