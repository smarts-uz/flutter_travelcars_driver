import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

class DataModel {
  DataModel({
    required this.data,
  });

  List<Datum> data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        data: json["data"] == null
            ? List<Datum>.from({})
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.price,
    required this.date,
    required this.dateReverse,
    required this.reverse,
    required this.duration,
    required this.cityFrom,
    required this.cityTo,
    required this.car,
    required this.carNumber,
    required this.carColor,
    required this.rating,
    required this.comment,
    required this.paid,
    required this.status,
    required this.bookDate,
    required this.bookTime,
    required this.additional,
    required this.activeDate,
  });

  int id;
  String userName;
  String userEmail;
  String userPhone;
  String price;
  String date;
  String dateReverse;
  int reverse;
  String duration;
  String cityFrom;
  String cityTo;
  String car;
  String carNumber;
  String carColor;
  int rating;
  String comment;
  String paid;
  String status;
  String bookDate;
  String bookTime;
  String additional;
  String activeDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        userName: json["user_name"] ?? "",
        userEmail: json["user_email"] ?? "",
        userPhone: json["user_phone"] ?? "",
        price: json["price"] ?? "",
        date: json["date"] ?? "",
        dateReverse: json["date_reverse"] ?? "",
        reverse: json["reverse"] ?? 0,
        duration: json["duration"] ?? "",
        cityFrom: json["city_from"] ?? "",
        cityTo: json["city_to"] ?? "",
        car: json["car"] ?? "",
        carNumber: json["car_number"] ?? "",
        carColor: json["car_color"] ?? "",
        rating: json["rating"] ?? 0,
        comment: json["comment"] ?? "",
        paid: json["paid"] ?? "",
        status: json["status"] ?? "",
        bookDate: json["book_date"] ?? "",
        bookTime: json["book_time"] ?? "",
        additional: json["additional"] ?? "",
        activeDate: json["active_date"] ?? "",
      );
}
