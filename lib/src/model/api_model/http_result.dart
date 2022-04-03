class HttpResult {
  int statusCode;
  bool isSuccess;
  // ignore: prefer_typing_uninitialized_variables
  var result;

  HttpResult({
    required this.statusCode,
    required this.isSuccess,
    required this.result,
  });
}