import 'dart:convert';

import 'package:flutter_travelcars_driver/src/model/api_model/home_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/repository.dart';

class HomeBloc {
  final Repository _repository = Repository();

  final _homeFetch = PublishSubject<HomeModel>();

  Stream<HomeModel> get homeFeedback => _homeFetch.stream;

  Future<HttpResult> setLogin(String login, String password) async {
    try {
      HttpResult response = await _repository.loginApi(login, password);
      if (response.isSuccess) {
        HomeModel data = homeModelFromJson(
          json.encode(response.result),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", data.data.apiToken);

        _homeFetch.sink.add(data);
        return response;
      }
      else {
        return response;
      }
    } catch (_) {
      return HttpResult(
        statusCode: 0,
        isSuccess: false,
        result: "Login yoki parol xato!",
      );
    }
  }
}

final homeBloc = HomeBloc();
