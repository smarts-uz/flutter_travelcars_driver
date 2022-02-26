class HttpResult {
  int statusCode;
  bool isSuccess;
  var result;

  HttpResult({
    required this.statusCode,
    required this.isSuccess,
    required this.result,
  });
}