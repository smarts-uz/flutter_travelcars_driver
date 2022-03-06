import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

class HistoryModel {
  HistoryModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data: json["data"] == null
            ? List<Datum>.from(<Datum>[])
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: json["links"] == null
            ? Links.fromJson({})
            : Links.fromJson(json["links"]),
        meta: json["meta"] == null
            ? Meta.fromJson({})
            : Meta.fromJson(json["meta"]),
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
  String rating;
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
        rating: json["rating"] ?? "",
        comment: json["comment"] ?? "",
        paid: json["paid"] ?? "",
        status: json["status"] ?? "",
        bookDate: json["book_date"] ?? "",
        bookTime: json["book_time"] ?? "",
        additional: json["additional"] ?? "",
        activeDate: json["active_date"] ?? "",
      );
}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  String prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] ?? "",
        last: json["last"] ?? "",
        prev: json["prev"] ?? "",
        next: json["next"] ?? "",
      );
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"] ?? 0,
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? 0,
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
      );
}
