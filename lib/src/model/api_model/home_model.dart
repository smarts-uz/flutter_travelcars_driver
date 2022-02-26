import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
  HomeModel({
    required this.data,
  });

  Data data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.birthday,
    required this.apiToken,
    required this.licenceNumber,
    required this.regDate,
    required this.regTime,
  });

  int id;
  String name;
  String email;
  String username;
  String phone;
  String birthday;
  String apiToken;
  String licenceNumber;
  String regDate;
  String regTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
        phone: json["phone"] ?? "",
        birthday: json["birthday"] ?? "",
        apiToken: json["api_token"] ?? "",
        licenceNumber: json["licence_number"] ?? "",
        regDate: json["reg_date"] ?? "",
        regTime: json["reg_time"] ?? "",
      );
}
