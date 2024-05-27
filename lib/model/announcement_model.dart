// To parse this JSON data, do
//
//     final announcement = announcementFromJson(jsonString);

import 'dart:convert';

Announcement announcementFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  bool status;
  String message;
  Data data;

  Announcement({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Notice> notices;

  Data({
    required this.notices,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notices:
            List<Notice>.from(json["notices"].map((x) => Notice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notices": List<dynamic>.from(notices.map((x) => x.toJson())),
      };
}

class Notice {
  String noticeId;
  String title;
  String notice;
  String schoolyearId;
  DateTime date;
  DateTime createDate;
  String createUserId;
  String createUsertypeId;

  Notice({
    required this.noticeId,
    required this.title,
    required this.notice,
    required this.schoolyearId,
    required this.date,
    required this.createDate,
    required this.createUserId,
    required this.createUsertypeId,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        noticeId: json["noticeID"],
        title: json["title"],
        notice: json["notice"],
        schoolyearId: json["schoolyearID"],
        date: DateTime.parse(json["date"]),
        createDate: DateTime.parse(json["create_date"]),
        createUserId: json["create_userID"],
        createUsertypeId: json["create_usertypeID"],
      );

  Map<String, dynamic> toJson() => {
        "noticeID": noticeId,
        "title": title,
        "notice": notice,
        "schoolyearID": schoolyearId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "create_date": createDate.toIso8601String(),
        "create_userID": createUserId,
        "create_usertypeID": createUsertypeId,
      };
}
