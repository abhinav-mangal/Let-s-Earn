// To parse this JSON data, do
//
//     final PurchaceModel = PurchaceModelFromJson(jsonString);

import 'dart:convert';

PurchaceModel purchaceModelFromJson(String str) => PurchaceModel.fromJson(json.decode(str));

String purchaceModelToJson(PurchaceModel data) => json.encode(data.toJson());

class PurchaceModel {
    PurchaceModel({
        required this.status,
        required this.account,
        required this.address,
        required this.message,
    });

    bool status;
    String account;
    String address;
    String message;

    factory PurchaceModel.fromJson(Map<String, dynamic> json) => PurchaceModel(
        status: json["status"],
        account: json["account"],
        address: json["address"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "account": account,
        "address": address,
        "message": message,
    };
}
