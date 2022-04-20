import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';

import '../model/api_model/weather_model.dart';

class WeatherBloc {
  Repository repository = Repository();

  final _weatherFetch = PublishSubject<WeatherModel>();

  Stream<WeatherModel> get weatherFeedBack => _weatherFetch.stream;

  getWeather() async {
    try {
      HttpResult response = await repository.getWeather();
      if (response.isSuccess) {
        WeatherModel data = weatherModelFromJson(
          json.encode(response.result),
        );
        _weatherFetch.sink.add(data);
      }
    } catch (_) {}
  }

  dispose() {
    _weatherFetch.close();
  }
}

final weatherBloc = WeatherBloc();
