import 'dart:convert';

ProfileEditModel profileEditModelFromJson(String str) =>
    ProfileEditModel.fromJson(json.decode(str));

class ProfileEditModel {
  ProfileEditModel({
    required this.message,
  });

  String message;

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) =>
      ProfileEditModel(
        message: json["message"] ?? "",
      );
}
