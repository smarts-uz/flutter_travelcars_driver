import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:rxdart/rxdart.dart';

class HistoryBloc {
  Repository repository = Repository();

  final _historyFetch = PublishSubject<HistoryModel>();

  Stream<HistoryModel> get historyFeedback => _historyFetch.stream;

  getAllHistory(String type, int page) async {
    try {
      HttpResult response = await repository.getHistory(type, page);
      if (response.isSuccess) {
        HistoryModel data = historyModelFromJson(
          json.encode(response.result),
        );
        _historyFetch.sink.add(data);
      }
      print("Successs");
    } catch (e) {
      print(e);
    }
  }
}

final historyBloc = HistoryBloc();
