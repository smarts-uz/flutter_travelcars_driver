import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

class TaskModel {
  TaskModel({
    required this.data,
  });

  Data data;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        data: json["data"] == null
            ? Data.fromJson({})
            : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.done,
    required this.active,
    required this.proceed,
    required this.rejected,
  });

  int done;
  int active;
  int proceed;
  int rejected;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        done: json["done"] ?? 0,
        active: json["active"] ?? 0,
        proceed: json["proceed"] ?? 0,
        rejected: json["rejected"] ?? 0,
      );
}
