// To parse this JSON data, do
//
//     final recordModal = recordModalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RecordModal recordModalFromJson(String str) =>
    RecordModal.fromJson(json.decode(str));

String recordModalToJson(RecordModal data) => json.encode(data.toJson());

class RecordModal {
  RecordModal({
    required this.status,
    required this.picked,
    required this.pending,
    required this.completed,
    required this.failed,
    required this.message,
  });

  bool status;
  List<Picked>? picked;
  List<Pending>? pending;
  List<Completed>? completed;
  List<Failed>? failed;
  String message;

  factory RecordModal.fromJson(Map<String, dynamic> json) => RecordModal(
        status: json["status"],
        picked:
            List<Picked>.from(json["picked"].map((x) => Picked.fromJson(x))),
        pending:
            List<Pending>.from(json["pending"].map((x) => Pending.fromJson(x))),
        completed: List<Completed>.from(
            json["completed"].map((x) => Completed.fromJson(x))),
        failed:
            List<Failed>.from(json["failed"].map((x) => Failed.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "picked": List<dynamic>.from(picked!.map((x) => x.toJson())),
        "pending": List<dynamic>.from(pending!.map((x) => x)),
        "completed": List<dynamic>.from(completed!.map((x) => x.toJson())),
        "failed": List<dynamic>.from(failed!.map((x) => x)),
        "message": message,
      };
}

class Completed {
  Completed({
    this.youtubeLinkId,
    this.youtubeLinkSno,
    this.youtubeLink,
    this.youtubeChannelName,
    this.linkCreatedDate,
    this.taskCreatedDate,
    this.taskId,
    this.taskStatus,
    this.bonus,
  });

  String? youtubeLinkId;
  String? youtubeLinkSno;
  String? youtubeLink;
  String? youtubeChannelName;
  DateTime? linkCreatedDate;
  DateTime? taskCreatedDate;
  String? taskId;
  String? taskStatus;
  String? bonus;

  factory Completed.fromJson(Map<String, dynamic> json) => Completed(
        youtubeLinkId: json["youtube_link_id"],
        youtubeLinkSno: json["youtube_link_sno"],
        youtubeLink: json["youtube_link"],
        youtubeChannelName: json["youtube_channel_name"],
        linkCreatedDate: DateTime.parse(json["link_created_date"]),
        taskCreatedDate: DateTime.parse(json["task_created_date"]),
        taskId: json["task_id"],
        taskStatus: json["task_status"],
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "youtube_link_id": youtubeLinkId,
        "youtube_link_sno": youtubeLinkSno,
        "youtube_link": youtubeLink,
        "youtube_channel_name": youtubeChannelName,
        "link_created_date": linkCreatedDate!.toIso8601String(),
        "task_created_date": taskCreatedDate!.toIso8601String(),
        "task_id": taskId,
        "task_status": taskStatus,
        "bonus": bonus,
      };
}

class Picked {
  Picked({
    this.youtubeLinkId,
    this.youtubeLinkSno,
    this.youtubeLink,
    this.youtubeChannelName,
    this.linkCreatedDate,
    this.taskCreatedDate,
    this.taskId,
    this.taskStatus,
    this.bonus,
  });

  String? youtubeLinkId;
  String? youtubeLinkSno;
  String? youtubeLink;
  String? youtubeChannelName;
  DateTime? linkCreatedDate;
  DateTime? taskCreatedDate;
  String? taskId;
  String? taskStatus;
  String? bonus;

  factory Picked.fromJson(Map<String, dynamic> json) => Picked(
        youtubeLinkId: json["youtube_link_id"],
        youtubeLinkSno: json["youtube_link_sno"],
        youtubeLink: json["youtube_link"],
        youtubeChannelName: json["youtube_channel_name"],
        linkCreatedDate: DateTime.parse(json["link_created_date"]),
        taskCreatedDate: DateTime.parse(json["task_created_date"]),
        taskId: json["task_id"],
        taskStatus: json["task_status"],
        bonus: json["bonus"]
      );

  Map<String, dynamic> toJson() => {
        "youtube_link_id": youtubeLinkId,
        "youtube_link_sno": youtubeLinkSno,
        "youtube_link": youtubeLink,
        "youtube_channel_name": youtubeChannelName,
        "link_created_date": linkCreatedDate!.toIso8601String(),
        "task_created_date": taskCreatedDate!.toIso8601String(),
        "task_id": taskId,
        "task_status": taskStatus,
        "bonus": bonus,
      };
}

class Pending {
  Pending({
    this.youtubeLinkId,
    this.youtubeLinkSno,
    this.youtubeLink,
    this.youtubeChannelName,
    this.linkCreatedDate,
    this.taskCreatedDate,
    this.taskId,
    this.taskStatus,
    this.bonus,
  });

  String? youtubeLinkId;
  String? youtubeLinkSno;
  String? youtubeLink;
  String? youtubeChannelName;
  DateTime? linkCreatedDate;
  DateTime? taskCreatedDate;
  String? taskId;
  String? taskStatus;
  String? bonus;

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
        youtubeLinkId: json["youtube_link_id"],
        youtubeLinkSno: json["youtube_link_sno"],
        youtubeLink: json["youtube_link"],
        youtubeChannelName: json["youtube_channel_name"],
        linkCreatedDate: DateTime.parse(json["link_created_date"]),
        taskCreatedDate: DateTime.parse(json["task_created_date"]),
        taskId: json["task_id"],
        taskStatus: json["task_status"],
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "youtube_link_id": youtubeLinkId,
        "youtube_link_sno": youtubeLinkSno,
        "youtube_link": youtubeLink,
        "youtube_channel_name": youtubeChannelName,
        "link_created_date": linkCreatedDate!.toIso8601String(),
        "task_created_date": taskCreatedDate!.toIso8601String(),
        "task_id": taskId,
        "task_status": taskStatus,
        "bonus": bonus,
      };
}

class Failed {
  Failed({
    this.youtubeLinkId,
    this.youtubeLinkSno,
    this.youtubeLink,
    this.youtubeChannelName,
    this.linkCreatedDate,
    this.taskCreatedDate,
    this.taskId,
    this.taskStatus,
    this.bonus,
  });

  String? youtubeLinkId;
  String? youtubeLinkSno;
  String? youtubeLink;
  String? youtubeChannelName;
  DateTime? linkCreatedDate;
  DateTime? taskCreatedDate;
  String? taskId;
  String? taskStatus;
  String? bonus;

  factory Failed.fromJson(Map<String, dynamic> json) => Failed(
        youtubeLinkId: json["youtube_link_id"],
        youtubeLinkSno: json["youtube_link_sno"],
        youtubeLink: json["youtube_link"],
        youtubeChannelName: json["youtube_channel_name"],
        linkCreatedDate: DateTime.parse(json["link_created_date"]),
        taskCreatedDate: DateTime.parse(json["task_created_date"]),
        taskId: json["task_id"],
        taskStatus: json["task_status"],
        bonus: json["bonus"],
      );

  Map<String, dynamic> toJson() => {
        "youtube_link_id": youtubeLinkId,
        "youtube_link_sno": youtubeLinkSno,
        "youtube_link": youtubeLink,
        "youtube_channel_name": youtubeChannelName,
        "link_created_date": linkCreatedDate!.toIso8601String(),
        "task_created_date": taskCreatedDate!.toIso8601String(),
        "task_id": taskId,
        "task_status": taskStatus,
        "bonus": bonus,
      };
}
