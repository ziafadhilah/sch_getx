// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  bool status;
  String message;
  Data data;

  Video({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
  List<VideoElement> videos;

  Data({
    required this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        videos: List<VideoElement>.from(
            json["videos"].map((x) => VideoElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class VideoElement {
  String videoId;
  String url;
  String title;
  DateTime date;

  VideoElement({
    required this.videoId,
    required this.url,
    required this.title,
    required this.date,
  });

  factory VideoElement.fromJson(Map<String, dynamic> json) => VideoElement(
        videoId: json["videoID"],
        url: json["url"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "videoID": videoId,
        "url": url,
        "title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
