// To parse this JSON data, do
//
//     final bankDetailsModel = bankDetailsModelFromJson(jsonString);

import 'dart:convert';

BankDetailsModel bankDetailsModelFromJson(String str) =>
    BankDetailsModel.fromJson(json.decode(str));

String bankDetailsModelToJson(BankDetailsModel data) =>
    json.encode(data.toJson());

class BankDetailsModel {
  BankDetailsModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  BankDetailsData? data;
  String? message;

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) =>
      BankDetailsModel(
        status: json["status"],
        data: BankDetailsData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
      };
}

class BankDetailsData {
  BankDetailsData({
    this.accountNo,
    this.holderName,
    this.ifscCode,
    this.branchName,
    this.upiId,
    this.upiName,
  });

  String? accountNo;
  String? holderName;
  String? ifscCode;
  String? branchName;
  String? upiId;
  String? upiName;

  factory BankDetailsData.fromJson(Map<String, dynamic> json) => BankDetailsData(
        accountNo: json["account_no"],
        holderName: json["holder_name"],
        ifscCode: json["ifsc_code"],
        branchName: json["branch_name"],
        upiId: json["upi_id"],
        upiName: json["upi_name"],
      );

  Map<String, dynamic> toJson() => {
        "account_no": accountNo,
        "holder_name": holderName,
        "ifsc_code": ifscCode,
        "branch_name": branchName,
        "upi_id": upiId,
        "upi_name": upiName,
      };
}
