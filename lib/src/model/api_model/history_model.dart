import 'dart:convert';

import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

class HistoryModel {
  HistoryModel({
    required this.data,
    required this.data1,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  List<Datum> data1;
  Links links;
  Meta meta;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data: json["data"] == null
            ? List<Datum>.from(<Datum>[])
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        data1: List<Datum>.from(<Datum>[]),
        links: json["links"] == null
            ? Links.fromJson({})
            : Links.fromJson(json["links"]),
        meta: json["meta"] == null
            ? Meta.fromJson({})
            : Meta.fromJson(json["meta"]),
      );
}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  String prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] ?? "",
        last: json["last"] ?? "",
        prev: json["prev"] ?? "",
        next: json["next"] ?? "",
      );
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"] ?? 0,
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? 0,
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
      );
}
