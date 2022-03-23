import 'dart:convert';

import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';

OnlineTaskModel onlineTaskModelModelFromJson(String str) =>
    OnlineTaskModel.fromJson(json.decode(str));

class OnlineTaskModel {
  OnlineTaskModel({
    required this.data,
  });

  Datum data;

  factory OnlineTaskModel.fromJson(Map<String, dynamic> json) =>
      OnlineTaskModel(
        data: Datum.fromJson(json["data"]),
      );
}
