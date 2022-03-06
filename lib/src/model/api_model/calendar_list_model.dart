import 'dart:convert';

CalendarListModel calendarListModelFromJson(String str) =>
    CalendarListModel.fromJson(json.decode(str));

class CalendarListModel {
  CalendarListModel({
    required this.data,
  });

  List<Datum> data;

  factory CalendarListModel.fromJson(Map<String, dynamic> json) =>
      CalendarListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.id,
    required this.date,
    required this.price,
    required this.booked,
    required this.bookingId,
    required this.status,
    required this.reverse,
    required this.duration,
    required this.cityFrom,
    required this.cityTo,
    required this.car,
    required this.carNumber,
  });

  int id;
  String date;
  int price;
  int booked;
  int bookingId;
  int status;
  int reverse;
  String duration;
  String cityFrom;
  String cityTo;
  String car;
  String carNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        date: json["date"] ?? "",
        price: json["price"] ?? 0,
        booked: json["booked"] ?? 0,
        bookingId: json["booking_id"] ?? 0,
        status: json["status"] ?? 0,
        reverse: json["reverse"] ?? 0,
        duration: json["duration"] ?? "",
        cityFrom: json["city_from"] ?? "",
        cityTo: json["city_to"] ?? "",
        car: json["car"] ?? "",
        carNumber: json["car_number"] ?? "",
      );
}
