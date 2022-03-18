import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';

class CalendarViewModel{
  String car;
  String carNumber;
  int bookingId;
  List<Datum> data;
  CalendarViewModel({
    required this.carNumber,
    required this.car,
    required this.bookingId,
    required this.data,
});
}