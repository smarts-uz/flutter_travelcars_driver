import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class ListBloc {
  Repository repository = Repository();

  final _listFetch = PublishSubject<CalendarListModel>();

  Stream<CalendarListModel> get listFeedBack => _listFetch.stream;

  getAllList(DateTime date) async {
    HttpResult response = await repository.getCalendarList(date);
    if (response.isSuccess) {
      CalendarListModel data = calendarListModelFromJson(
        json.encode(response.result),
      );
      _listFetch.sink.add(data);
    }
  }

  dispose() {
    _listFetch.close();
  }
}

final listBloc = ListBloc();
