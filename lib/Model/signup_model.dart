// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        required this.status,
        required this.message,
        required this.id,
        required this.phone,
    });

    bool status;
    String message;
    int? id;
    String? phone;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        id: json["id"] == null ? null : json["id"],
        phone: json["phone"] == null ? null : json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "id": id == null ? null : id,
        "phone": phone == null ? null : phone,
    };
}
