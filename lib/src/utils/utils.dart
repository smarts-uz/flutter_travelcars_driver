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
      return "Январь";
    case 2:
      return "  Февраль";
    case 3:
      return "Март";
    case 4:
      return "Апрель";
    case 5:
      return "Май";
    case 6:
      return "Июнь";
    case 7:
      return "Июль";
    case 8:
      return "Август";
    case 9:
      return "Сентябрь";
    case 10:
      return "Октябрь";
    case 11:
      return "Ноябрь";
    case 12:
      return "Декабрь";
  }

  return "";
}
