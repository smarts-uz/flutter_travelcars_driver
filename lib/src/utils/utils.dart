import 'package:flutter/cupertino.dart';

class Utils {
  static double height(BuildContext context) {
    return (MediaQuery.of(context).size.height / 926);
  }

  static double width(BuildContext context) {
    return (MediaQuery.of(context).size.width / 428);
  }

  static String getDateHours(DateTime date) {
    return "${date.hour < 10 ? "0${date.hour}" : date.hour} : ${date.minute < 10 ? "0${date.minute}" : date.minute}";
  }

  static String getDateDay(DateTime date) {
    return "${date.day} ${getMonth(date.month)}";
  }

  static String getDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}:${date.second}";
  }
}

String getMonth(int n) {
  switch (n) {
    case 1:
      return "январь";
    case 2:
      return "февраля";
    case 3:
      return "март";
    case 4:
      return "апрель";
    case 5:
      return "май";
    case 6:
      return "июнь";
    case 7:
      return "июль";
    case 8:
      return "август";
    case 9:
      return "сентябрь";
    case 10:
      return "октябрь";
    case 11:
      return "ноябрь";
    case 12:
      return "декабрь";
  }
  return "";
}
