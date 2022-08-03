// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    BannerModel({
        required this.status,
        required this.banner,
    });

    bool status;
    List<String>? banner;

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        status: json["status"] == null ? null : json["status"],
        banner: json["banner"] == null ? null : List<String>.from(json["banner"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "banner": banner == null ? null : List<dynamic>.from(banner!.map((x) => x)),
    };
}
