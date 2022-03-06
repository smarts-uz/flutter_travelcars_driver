import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) => List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

class CourseModel {
    CourseModel({
        required this.title,
        required this.code,
        required this.cbPrice,
        required this.nbuBuyPrice,
        required this.nbuCellPrice,
        required this.date,
    });

    String title;
    String code;
    String cbPrice;
    String nbuBuyPrice;
    String nbuCellPrice;
    String date;

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        title: json["title"] ?? "",
        code: json["code"] ?? "",
        cbPrice: json["cb_price"] ?? "",
        nbuBuyPrice: json["nbu_buy_price"] ?? "",
        nbuCellPrice: json["nbu_cell_price"] ?? "",
        date: json["date"] ?? "",
    );
}
