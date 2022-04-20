import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/online_task_model.dart';
import 'package:rxdart/rxdart.dart';

class OnlineTaskViewBloc {
  Repository repository = Repository();

  final _taskFetch = PublishSubject<OnlineTaskModel>();

  Stream<OnlineTaskModel> get oneTask => _taskFetch.stream;

  getTask(String id) async {
    HttpResult response = await repository.getShow(id);
    if (response.isSuccess) {
      OnlineTaskModel data = onlineTaskModelModelFromJson(
        json.encode(
          response.result,
        ),
      );
      _taskFetch.sink.add(data);
    }
  }

  dispose() {
    _taskFetch.close();
  }
}

final onlineTaskBloc = OnlineTaskViewBloc();
