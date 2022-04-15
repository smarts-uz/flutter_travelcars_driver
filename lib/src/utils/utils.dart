import 'package:flutter/cupertino.dart';

class Utils {
  static double height(BuildContext context) {
    return (MediaQuery.of(context).size.height / 812);
  }

  static double width(BuildContext context) {
    return (MediaQuery.of(context).size.width / 375);
  }

  static String getDateHours(DateTime date) {
    return "${date.hour < 10 ? "0${date.hour}" : date.hour} : ${date.minute < 10 ? "0${date.minute}" : date.minute}";
  }

  static String getDateDay(DateTime date) {
    return "${date.day} ${getMonth1(date.month)}";
  }

  static String getDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}:${date.second}";
  }

  static String getCarNumber(String number) {
    String k = "";
    k = number[0] + number[1] + " ";
    try {
      k += int.parse(number[2]).toString() +
          number[3] +
          number[4] +
          " " +
          number[5] +
          number[6] +
          number[7];
    } catch (e) {
      print(e);
      k += number[2] +
          " " +
          number[3] +
          number[4] +
          number[5] +
          " " +
          number[6] +
          number[7];
    }
    return k;
  }
}

String getMonth(int n) {
  switch (n) {
    case 1:
      return "Январь";
    case 2:
      return "Февраль";
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

String getMonth1(int n) {
  switch (n) {
    case 1:
      return "января";
    case 2:
      return "февраля";
    case 3:
      return "марта";
    case 4:
      return "апреля";
    case 5:
      return "мая";
    case 6:
      return "июня";
    case 7:
      return "июля";
    case 8:
      return "августа";
    case 9:
      return "сентября";
    case 10:
      return "октября";
    case 11:
      return "ноября";
    case 12:
      return "декабря";
  }

  return "";
}
