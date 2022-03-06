import 'dart:convert';

ProfileEditModel profileEditModelFromJson(String str) =>
    ProfileEditModel.fromJson(json.decode(str));

class ProfileEditModel {
  ProfileEditModel({
    required this.resultMessage,
  });

  String resultMessage;

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) =>
      ProfileEditModel(
        resultMessage: json["result_message"] ?? "",
      );
}
