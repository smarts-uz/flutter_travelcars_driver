import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) => List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

class CourseModel {
    CourseModel({
        required this.id,
        required this.code,
        required this.ccy,
        required this.ccyNmRu,
        required this.ccyNmUz,
        required this.ccyNmUzc,
        required this.ccyNmEn,
        required this.nominal,
        required this.rate,
        required this.diff,
        required this.date,
    });

    int id;
    String code;
    String ccy;
    String ccyNmRu;
    String ccyNmUz;
    String ccyNmUzc;
    String ccyNmEn;
    String nominal;
    String rate;
    String diff;
    String date;

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"] ?? 0,
        code: json["Code"] ?? "",
        ccy: json["Ccy"] ?? "",
        ccyNmRu: json["CcyNm_RU"] ?? "",
        ccyNmUz: json["CcyNm_UZ"] ?? "",
        ccyNmUzc: json["CcyNm_UZC"] ?? "",
        ccyNmEn: json["CcyNm_EN"] ?? "",
        nominal: json["Nominal"] ?? "",
        rate: json["Rate"] ?? "",
        diff: json["Diff"] ?? "",
        date: json["Date"] ?? "",
    );
}
