// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ScheduleList> scheduleListFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ScheduleList>.from(jsonData["data"].map((item) => ScheduleList.fromJson(item)));
}

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  final Data data;

  Schedule({
    required this.data,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  final List<ScheduleList> schedule;

  Data({
    required this.schedule,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    schedule: List<ScheduleList>.from(json["data"].map((x) => ScheduleList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(schedule.map((x) => x.toJson())),
  };
}

class ScheduleList {
  final int id;
  final bool is_open;
  final String days;
  final String start_time;
  final String end_time;
  final int? temporary_closure_duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ScheduleList(
      {
        required  this.id,
        required  this.is_open,
        required this.days,
        required  this.start_time,
        required this.end_time,
        this.temporary_closure_duration,
        this.createdAt,
        this.updatedAt,

      });

  factory ScheduleList.fromJson(Map<String, dynamic> json) => ScheduleList(
    id: json["id"],
    is_open: json["is_open"],
    days: json["days"],
    start_time: json["start_time"],
    end_time: json["end_time"],
    temporary_closure_duration: json["temporary_closure_duration"] != null ? int.parse(json["temporary_closure_duration"]) : null,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_open": is_open,
    "days": days,
    "start_time": start_time,
    "end_time": end_time,
    "temporary_closure_duration": temporary_closure_duration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'ScheduleList(id: $id, is_open: $is_open, days: $days, start_time: $start_time, end_time: $end_time,temporary_closure_duration: $temporary_closure_duration)';
  }
}




