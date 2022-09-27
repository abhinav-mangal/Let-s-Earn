// To parse this JSON data, do
//
//     final inviteYourFriends = inviteYourFriendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

InviteYourFriends inviteYourFriendsFromJson(String str) => InviteYourFriends.fromJson(json.decode(str));

String inviteYourFriendsToJson(InviteYourFriends data) => json.encode(data.toJson());

class InviteYourFriends {
    InviteYourFriends({
        required this.status,
        required this.data,
        required this.message,
    });

    bool status;
    List<String> data;
    String message;

    factory InviteYourFriends.fromJson(Map<String, dynamic> json) => InviteYourFriends(
        status: json["status"],
        data: List<String>.from(json["data"].map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x)),
        "message": message,
    };
}
