  import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/calendar_view_model.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc {
  Repository repository = Repository();

  final _listFetch = PublishSubject<List<CalendarViewModel>>();

  Stream<List<CalendarViewModel>> get listFeedBack => _listFetch.stream;

  getAllList(DateTime date) async {
    HttpResult response = await repository.getCalendarList(date);
    List<CalendarViewModel> repo = <CalendarViewModel>[];
    if (response.isSuccess) {
      CalendarListModel data = calendarListModelFromJson(
        json.encode(response.result),
      );
      for (int i = 0; i < data.data.length; i++) {
        bool k = false;
        bool t = false;
        List<Datum> list = <Datum>[];
        for (int j = 0; j < repo.length; j++) {
          if (repo[j].car == data.data[i].car &&
              repo[j].carNumber == data.data[i].carNumber) {
            k = true;
          }
        }
        if (!k) {
          for (int j = 0; j < data.data.length; j++) {
            if (data.data[i].car == data.data[j].car &&
                data.data[i].carNumber == data.data[j].carNumber) {
              list.add(data.data[j]);
              if (data.data[j].bookingId != 0 && !t) {
                t = true;
              }
            }
          }
          repo.add(
            CalendarViewModel(
              carNumber: data.data[i].carNumber,
              car: data.data[i].car,
              bookingId: t ? 1 : 0,
              data: list,
            ),
          );
        }
      }
    }
    _listFetch.sink.add(repo);
  }

  dispose() {
    _listFetch.close();
  }
}

final listBloc = ListBloc();
