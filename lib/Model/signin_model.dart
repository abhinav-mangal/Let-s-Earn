// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
    SignInModel({
        required this.status,
        required this.message,
        required this.userId,
        required this.userPhone,
    });

    bool status;
    String message;
    String userId;
    String userPhone;

    factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "user_id": userId == null ? null : userId,
        "user_phone": userPhone == null ? null : userPhone,
    };
}
