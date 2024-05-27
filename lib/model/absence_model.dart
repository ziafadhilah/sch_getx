// To parse this JSON data, do
//
//     final absence = absenceFromJson(jsonString);

import 'dart:convert';

Absence absenceFromJson(String str) => Absence.fromJson(json.decode(str));

String absenceToJson(Absence data) => json.encode(data.toJson());

class Absence {
  bool status;
  Data data;

  Absence({
    required this.status,
    required this.data,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<Attendance> attendance;
  String tokenData;

  Data({
    required this.attendance,
    required this.tokenData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attendance: List<Attendance>.from(
            json["attendance"].map((x) => Attendance.fromJson(x))),
        tokenData: json["tokenData"],
      );

  Map<String, dynamic> toJson() => {
        "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
        "tokenData": tokenData,
      };
}

class Attendance {
  String rfidattendanceId;
  String status;
  DateTime createDate;
  String studentId;
  String photo;
  String usertypeId;
  DateTime datetime;
  String name;
  String srclasses;
  String srsection;
  String? timein;
  String? timeout;

  Attendance({
    required this.rfidattendanceId,
    required this.status,
    required this.createDate,
    required this.studentId,
    required this.photo,
    required this.usertypeId,
    required this.datetime,
    required this.name,
    required this.srclasses,
    required this.srsection,
    required this.timein,
    required this.timeout,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        rfidattendanceId: json["rfidattendanceID"],
        status: json["status"],
        createDate: DateTime.parse(json["create_date"]),
        studentId: json["studentID"],
        photo: json["photo"],
        usertypeId: json["usertypeID"],
        datetime: DateTime.parse(json["datetime"]),
        name: json["name"],
        srclasses: json["srclasses"],
        srsection: json["srsection"],
        timein: json["timein"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "rfidattendanceID": rfidattendanceId,
        "status": status,
        "create_date": createDate.toIso8601String(),
        "studentID": studentId,
        "photo": photo,
        "usertypeID": usertypeId,
        "datetime":
            "${datetime.year.toString().padLeft(4, '0')}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}",
        "name": name,
        "srclasses": srclasses,
        "srsection": srsection,
        "timein": timein,
        "timeout": timeout,
      };
}
