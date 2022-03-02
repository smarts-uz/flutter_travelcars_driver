import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  Repository repository = Repository();
  final _dataFetch = PublishSubject<DataModel>();

  Stream<DataModel> get dataFeedback => _dataFetch.stream;

  getAllData() async {
    try {
      HttpResult response = await repository.getData();
      DataModel data = dataModelFromJson(
        json.encode(response.result),
      );
      _dataFetch.sink.add(data);
    } catch (_) {}
  }
}
final dataBloc = DataBloc();
