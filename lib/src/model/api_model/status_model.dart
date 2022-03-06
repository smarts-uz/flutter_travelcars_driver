import 'dart:convert';

StatusModel statusModelFromJson(String str) =>
    StatusModel.fromJson(json.decode(str));

class StatusModel {
  StatusModel({
    required this.the0,
    required this.message,
  });

  int the0;
  String message;

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        the0: json["0"] ?? 0,
        message: json["message"] ?? "",
      );
}
