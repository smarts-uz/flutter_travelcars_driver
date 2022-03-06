import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_model/http_result.dart';

class ApiProver {
  static Duration duration = const Duration(seconds: 30);
  String baseUrl = "https://api.travelcars.uz";

  ///post
  static Future<HttpResult> _postUrl(
    String url,
    data,
    bool newVersion,
  ) async {
    var header = await _header(newVersion);
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: header,
          )
          .timeout(duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "",
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "",
      );
    }
  }

  ///get
  static Future<HttpResult> _getResponse(String url,bool head) async {
    // ignore: avoid_print
    print(url);
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: await _header(head),
          )
          .timeout(duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "Internet error",
      );
    }
  }

  static HttpResult _result(http.Response response) {
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    } else if (response.statusCode >= 500) {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: "Server error",
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    }
  }

  ///header
  static Future<Map<String, String>?> _header(bool isNewVersion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isNewVersion) {
      return {"Authorization": "Bearer ${prefs.getString("token")}"};
    }
    return null;
  }

  ///login api
  Future<HttpResult> setLogin(String id, String password) async {
    var data = {
      "username": id,
      "password": password,
    };
    return await _postUrl(
      baseUrl + "/login",
      data,
      false,
    );
  }

  ///trips counts
  Future<HttpResult> getAllTasks() async {
    return await _getResponse(
      baseUrl + "/trips/counts",
      true,
    );
  }

  ///trips banners
  Future<HttpResult> getAllData() async {
    return await _getResponse(
      baseUrl + "/trips/banners",
      true,
    );
  }

  ///weather api
  Future<HttpResult> getWeather() async {
    return await _getResponse(
      "https://api.openweathermap.org/data/2.5/weather?q=Tashkent&appid=4d8fb5b93d4af21d66a2948710284366&units=metric",
      false,
    );
  }

  ///course api
  Future<HttpResult> getCourse() async {
    return await _getResponse(
      "https://nbu.uz/exchange-rates/json/",
      false,
    );
  }

  ///profile
  Future<HttpResult> getProfile() async {
    return await _getResponse(
      baseUrl + "/profile",
      true,
    );
  }

  ///profile edit
  Future<HttpResult> setEdit() async {
    return await _getResponse(
      baseUrl + "/profile/edit",
      true,
    );
  }
}
