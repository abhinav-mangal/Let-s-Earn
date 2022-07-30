// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);
import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
    SignInModel({
        required this.status,
        required this.msg,
    });

    bool status;
    String msg;

    factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}
