import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc {
  Repository repository = Repository();

  final _historyFetch = PublishSubject<HistoryModel>();

  Stream<HistoryModel> get historyFeedback => _historyFetch.stream;

  getAllHistory(String type, int page) async {
    DateTime _now = DateTime.now();
    try {
      HttpResult response = await repository.getHistory(type, page);
      if (response.isSuccess) {
        HistoryModel data = historyModelFromJson(
          json.encode(response.result),
        );
        for (int i = 0; i < data.data.length; i++) {
          String year = data.data[i].date[6] +
              data.data[i].date[7] +
              data.data[i].date[8] +
              data.data[i].date[9];
          String month = data.data[i].date[3] + data.data[i].date[4];
          String day = data.data[i].date[0] + data.data[i].date[1];
          if (_now.year == int.parse(year) &&
              _now.month == int.parse(month) &&
              _now.day == int.parse(day)) {
            data.data1.add(data.data[i]);
          }
        }
        _historyFetch.sink.add(data);
      }
    } catch (_) {}
  }
  dispose(){
    _historyFetch.close();
  }
}

final historyBloc = HistoryBloc();
