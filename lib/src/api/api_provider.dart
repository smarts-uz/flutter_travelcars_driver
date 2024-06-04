import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/api_model/http_result.dart';

class ApiProvider {
  static Duration duration = const Duration(seconds: 60);
  String baseUrl = "https://api.travelcars.uz";
  static const _secureStorage = FlutterSecureStorage();


  //header
  static Future<Map<String, String>> _header(bool isNewVersion, {Map<String, String>? additionalHeaders}) async {
    var headers = {
      'Accept': 'application/json',
    };
    if (isNewVersion) {
      String? apiToken = await _secureStorage.read(key: "api_token");
      print("Read token: $apiToken");
      if (apiToken != null) {
        headers['Authorization'] = "Bearer $apiToken";
        print("Token added to headers: $apiToken");
      } else {
        print("No API token found");
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  //postUrl
  static Future<HttpResult> _postUrl(
      String url,
      dynamic data,
      bool newVersion, {
        Map<String, String>? additionalHeaders,
      }) async {
    var header = await _header(newVersion, additionalHeaders: additionalHeaders);
    print("POST request to $url with headers: $header and data: $data");
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

  //getResponse
  static Future<HttpResult> _getResponse(String url, bool head, {Map<String, String>? additionalHeaders}) async {
    var header = await _header(head, additionalHeaders: additionalHeaders);
    print("GET request to $url with headers: $header");
    try {
      http.Response response = await http
          .get(
        Uri.parse(url),
        headers: header,
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

  ///result
  static HttpResult _result(http.Response response) {
    print("Response status: ${response.statusCode}, body: ${response.body}");
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

  ///login api
  Future<HttpResult> setLogin(String username, String password) async {
    var headers = {
      'Accept': 'application/json',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/login'),
    );
    request.fields.addAll({
      'username': username,
      'password': password,
    });
    request.headers.addAll(headers);
    print("Login request to $baseUrl with username: $username and password: $password");

    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['api_token'] != null) {
          String apiToken = responseData['api_token'];
          await deleteToken();
          await saveToken(apiToken);
        } else {
          print("API token not found in response");
        }
      } else {
        print("Login failed: ${response.reasonPhrase}");
      }
      return _result(response);
    } catch (e) {
      print("Error during login: $e");
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: e.toString(),
      );
    }
  }

  static Future<void> saveToken(String apiToken) async {
    await _secureStorage.write(key: "api_token", value: apiToken);
    print("Token saved: $apiToken");
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
      "https://api.openweathermap.org/data/2.5/weather?q=Tashkent&appid=4d8fb5b93d4af21d66a2948710284366&units=metric&lang=ru",
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
  Future<HttpResult> setEdit(
      String currentPassword,
      String newPass,
      String confirmNewPass,
      ) async {
    return await _postUrl(
      baseUrl + "/profile/edit",
      {
        'current_password': currentPassword,
        'new_password': newPass,
        'confirm_new_password': confirmNewPass,
      },
      true,
    );
  }

  ///calendar list
  Future<HttpResult> getListCalendar(DateTime date) async {
    return await _getResponse(
      baseUrl + "/routes/list?date=${date.year}-${date.month}-${date.day}",
      true,
    );
  }

  ///get history list
  Future<HttpResult> getHistory(String type, int page) async {
    return await _getResponse(
      baseUrl + "/trips/history?type=$type&page=$page",
      true,
    );
  }

  ///change status
  Future<HttpResult> changeStatus(int id) async {
    return await _getResponse(
      baseUrl + "/routes/status/$id",
      true,
    );
  }

  ///show tasks
  Future<HttpResult> getShow(String id) async {
    return await _getResponse(
      baseUrl + "/trips/show/$id",
      true,
    );
  }
  Future<HttpResult> logout() async {
    // Read the token from secure storage
    String? apiToken = await _secureStorage.read(key: "api_token");
    if (apiToken == null) {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "No API token found",
      );
    }

    var headers = {
      'Authorization': 'Bearer $apiToken',
      'Accept': 'application/json',
    };

    var request = http.Request('POST', Uri.parse('$baseUrl/logout'));
    request.headers.addAll(headers);

    print("Logout request to $baseUrl/logout with headers: $headers");

    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        await deleteToken();
      }
      return _result(response);
    } catch (e) {
      print("Error during logout: $e");
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: e.toString(),
      );
    }
  }
  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: "api_token");
    print("Token deleted");
  }
}
