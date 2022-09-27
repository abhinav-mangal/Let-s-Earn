// To parse this JSON data, do
//
//     final taskModal = taskModalFromJson(jsonString);

import 'dart:convert';

TaskModal taskModalFromJson(String str) => TaskModal.fromJson(json.decode(str));

String taskModalToJson(TaskModal data) => json.encode(data.toJson());

class TaskModal {
    TaskModal({
        required this.status,
        required this.data,
        required this.vipLevel,
        required this.message,
    });

    bool status;
    List<TaskData> data;
    String vipLevel;
    String message;

    factory TaskModal.fromJson(Map<String, dynamic> json) => TaskModal(
        status: json["status"],
        data: List<TaskData>.from(json["data"].map((x) => TaskData.fromJson(x))),
        vipLevel: json["vip-level"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "vip-level": vipLevel,
        "message": message,
    };
}

class TaskData {
    TaskData({
        required this.youtubeLinkId,
        required this.youtubeLinkSno,
        required this.youtubeLink,
        required this.youtubeChannelName,
        required this.missionCommision,
    });

    String youtubeLinkId;
    String youtubeLinkSno;
    String youtubeLink;
    String youtubeChannelName;
    String missionCommision;

    factory TaskData.fromJson(Map<String, dynamic> json) => TaskData(
        youtubeLinkId: json["youtube_link_id"],
        youtubeLinkSno: json["youtube_link_sno"],
        youtubeLink: json["youtube_link"],
        youtubeChannelName: json["youtube_channel_name"],
        missionCommision: json["mission-commision"],
    );

    Map<String, dynamic> toJson() => {
        "youtube_link_id": youtubeLinkId,
        "youtube_link_sno": youtubeLinkSno,
        "youtube_link": youtubeLink,
        "youtube_channel_name": youtubeChannelName,
        "mission-commision": missionCommision,
    };
}
